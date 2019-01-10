From: Vincent Stehle <Vincent.Stehle@arm.com>
Subject: Re: [PATCH] virtio:linux:kernel:NULL check after kmalloc is  needed
Date: Thu, 10 Jan 2019 08:13:27 +0000
Message-ID: <20190110081322.GA9056@debian>
References: <1546926033-31684-1-git-send-email-wang.yi59@zte.com.cn>
	<20190109093026-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190109093026-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-ID: <62E6D42661CCA64584508E52B364CFE3@eurprd08.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yi Wang <wang.yi59@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xue.zhihong@zte.com.cn" <xue.zhihong@zte.com.cn>, "huang.zijiang" <huang.zijiang@zte.com.cn>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On Wed, Jan 09, 2019 at 09:30:37AM -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 08, 2019 at 01:40:33PM +0800, Yi Wang wrote:
> > From: "huang.zijiang" <huang.zijiang@zte.com.cn>
> >
> > NULL check is needed because kmalloc maybe return NULL.
> >
> > Signed-off-by: huang.zijiang <huang.zijiang@zte.com.cn>
>
> Can't hurt I will queue it.
>
> > ---
> >  tools/virtio/linux/kernel.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> > index 7ef45a4..2afcad8 100644
> > --- a/tools/virtio/linux/kernel.h
> > +++ b/tools/virtio/linux/kernel.h
> > @@ -65,6 +65,8 @@ static inline void *kzalloc(size_t s, gfp_t gfp)
> >  {
> >  void *p = kmalloc(s, gfp);
> >
> > +if (!p)
> > +return -ENOMEM;
> >  memset(p, 0, s);
> >  return p;
> >  }

Shouldn't this kzalloc() function return NULL in case of error instead of
-ENOMEM?

Best regards,

Vincent.
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
