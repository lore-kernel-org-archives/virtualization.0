From: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC PATCH 2/6] virtio/console: Add a failback for unstealable
	pipe buffer
Date: Thu, 09 Aug 2012 12:58:13 +0300
Message-ID: <502389B5.4020506@redhat.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
	<20120724023718.6600.68836.stgit@ltc189.sdl.hitachi.co.jp>
	<20120809090312.GH3280@amit.redhat.com>
	<502381EA.80805@hitachi.com>
	<20120809095514.GJ3280@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120809095514.GJ3280@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, qemu-devel@nongnu.org, Frederic Weisbecker <fweisbec@gmail.com>, yrl.pp-manager.tt@hitachi.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/09/2012 12:55 PM, Amit Shah wrote:
> On (Thu) 09 Aug 2012 [18:24:58], Masami Hiramatsu wrote:
>> (2012/08/09 18:03), Amit Shah wrote:
>> > On (Tue) 24 Jul 2012 [11:37:18], Yoshihiro YUNOMAE wrote:
>> >> From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>> >>
>> >> Add a failback memcpy path for unstealable pipe buffer.
>> >> If buf->ops->steal() fails, virtio-serial tries to
>> >> copy the page contents to an allocated page, instead
>> >> of just failing splice().
>> >>
>> >> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>> >> Cc: Amit Shah <amit.shah@redhat.com>
>> >> Cc: Arnd Bergmann <arnd@arndb.de>
>> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >> ---
>> >>
>> >>  drivers/char/virtio_console.c |   28 +++++++++++++++++++++++++---
>> >>  1 files changed, 25 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>> >> index fe31b2f..911cb3e 100644
>> >> --- a/drivers/char/virtio_console.c
>> >> +++ b/drivers/char/virtio_console.c
>> >> @@ -794,7 +794,7 @@ static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
>> >>  			struct splice_desc *sd)
>> >>  {
>> >>  	struct sg_list *sgl = sd->u.data;
>> >> -	unsigned int len = 0;
>> >> +	unsigned int offset, len;
>> >>  
>> >>  	if (sgl->n == MAX_SPLICE_PAGES)
>> >>  		return 0;
>> >> @@ -807,9 +807,31 @@ static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
>> >>  
>> >>  		len = min(buf->len, sd->len);
>> >>  		sg_set_page(&(sgl->sg[sgl->n]), buf->page, len, buf->offset);
>> >> -		sgl->n++;
>> >> -		sgl->len += len;
>> >> +	} else {
>> >> +		/* Failback to copying a page */
>> >> +		struct page *page = alloc_page(GFP_KERNEL);
>> > 
>> > I prefer zeroing out the page.  If there's not enough data to be
>> > filled in the page, the remaining data can be leaked to the host.
>> 
>> Yeah, it is really easy to fix that.
>> But out of curiosity, would that be really a problem?
>> I guess that host can access any guest page if need. If that
>> is right, is that really insecure to leak randomly allocated
>> unused page to the host?
> 
> I'm not sure if there is a way to really attack, but just something I
> had thought about: the host kernel can access any guest page, that's
> not something we can prevent.
> 
> However, if qemu is restricted from accessing guest pages, and the
> guest shares this page with qemu for r/w purposes via the virtio
> channel, a qemu exploit can expose guest data to host userspace.
> 
> I agree this is completely theoretical; can someone else with more
> insight confirm or deny my apprehensions?

qemu can read and write any guest page (for the guest it controls).


-- 
error compiling committee.c: too many arguments to function
