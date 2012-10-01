From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 1/3] virtio_console:Merge struct buffer_token into struct
	port_buffer
Date: Mon, 1 Oct 2012 15:09:49 +0530
Message-ID: <20121001093949.GE9810@amit.redhat.com>
References: <1348580837-10919-1-git-send-email-sjur.brandeland@stericsson.com>
	<1348580837-10919-2-git-send-email-sjur.brandeland@stericsson.com>
	<50626C11.9040708@hitachi.com>
	<81C3A93C17462B4BBD7E272753C1057923BD8365F7@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057923BD8365F7@EXDCVYMBSTM005.EQ1STM.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Cc: "sjurbren@gmail.com" <sjurbren@gmail.com>, "Michael S.  Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "yrl.pp-manager.tt@hitachi.com" <yrl.pp-manager.tt@hitachi.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 26 Sep 2012 [09:48:12], Sjur BRENDELAND wrote:
> > > This merge reduces code size by unifying the approach for
> > > sending scatter-lists and regular buffers. Any type of
> > > write operation (splice, write, put_chars) will now allocate
> > > a port_buffer and send_buf() and free_buf() can always be used.
> > 
> > Thanks!
> > This looks much nicer and simpler. I just have some comments below.
> 
> OK, good to hear that you agree to this kind of change. I'll do a respin
> of this patch fixing the issues you have pointed out.
> 
> > >  static void free_buf(struct port_buffer *buf)
> > >  {
> > > +	int i;
> > > +
> > >  	kfree(buf->buf);
> > 
> > this should be done only when !buf->sgpages, or (see below)
> 
> Agree, I'll put this statement in an else branch to the if-statement below.

Not necessary; see my comments in another mail.

> > > -static struct port_buffer *alloc_buf(size_t buf_size)
> > > +static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
> > > +				     int nrbufs)
> > >  {
> > >  	struct port_buffer *buf;
> > > +	size_t alloc_size;
> > >
> > > -	buf = kmalloc(sizeof(*buf), GFP_KERNEL);
> > > +	/* Allocate buffer and the scatter list */
> > > +	alloc_size = sizeof(*buf) + sizeof(struct scatterlist) * nrbufs;
> > 
> > This allocates one redundant sg entry when nrbuf > 0,
> > but I think it is OK. (just a comment)
> 
> I did this on purpose for the sake of simplicity, but I can
> change this to something like:
> 	 alloc_size = sizeof(*buf) + sizeof(buf->sg) * max(nrbufs - 1, 1);
> 
> 
> > > +	buf = kmalloc(alloc_size, GFP_ATOMIC);
> > 
> > This should be kzalloc(), or buf->buf and others are not initialized,
> > which will cause unexpected kfree bug at kfree(buf->buf) in free_buf.
> 
> Agree, kzalloc() is better in this case. 

Not really -- one thing I've picked up from Rusty is to use kmallocs
and explicitly initialise values.  Then, missing such initialisations
(like in this case) will cause tools like valgrind to show the error
pretty quickly.

> > >  	if (!buf)
> > >  		goto fail;
> > > -	buf->buf = kzalloc(buf_size, GFP_KERNEL);
> > > +
> > > +	buf->sgpages = nrbufs;
> > > +	if (nrbufs > 0)
> > > +		return buf;
> > > +
> > > +	buf->buf = kmalloc(buf_size, GFP_ATOMIC);
> > 
> > You can also use kzalloc here as previous code does.
> > But if the reason why using kzalloc comes from the security,
> > I think kmalloc is enough here, since the host can access
> > all the guest pages anyway.
> 
> With this new patch alloc_buf() is used both for both RX and TX.
> The out_vq did previously use malloc(). But I have preserved
> the legacy behavior for the in_vq by calling memset() in function
> fill_queue().

But we're dropping the memset/kzalloc anyway.

		Amit
