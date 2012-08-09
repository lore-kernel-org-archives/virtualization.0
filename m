From: Borislav Petkov <bp@amd64.org>
Subject: Re: [RFC PATCH 2/6] virtio/console: Add a failback for unstealable
	pipe buffer
Date: Thu, 9 Aug 2012 11:24:46 +0200
Message-ID: <20120809092446.GB27761__4886.66631649739$1344634201$gmane$org@aftab.osrc.amd.com>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
	<20120724023718.6600.68836.stgit@ltc189.sdl.hitachi.co.jp>
	<20120809090312.GH3280@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120809090312.GH3280@amit.redhat.com>
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

On Thu, Aug 09, 2012 at 02:33:12PM +0530, Amit Shah wrote:
> > @@ -807,9 +807,31 @@ static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
> >  
> >  		len = min(buf->len, sd->len);
> >  		sg_set_page(&(sgl->sg[sgl->n]), buf->page, len, buf->offset);
> > -		sgl->n++;
> > -		sgl->len += len;
> > +	} else {
> > +		/* Failback to copying a page */
> > +		struct page *page = alloc_page(GFP_KERNEL);
> 
> I prefer zeroing out the page.  If there's not enough data to be
> filled in the page, the remaining data can be leaked to the host.

get_zeroed_page()?

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551
