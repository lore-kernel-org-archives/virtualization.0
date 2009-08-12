From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 2/2] vhost_net: a kernel-level virtio server
Date: Wed, 12 Aug 2009 13:52:42 +0300
Message-ID: <20090812105241.GA28848__14744.2251480699$1250074732$gmane$org@redhat.com>
References: <cover.1249992497.git.mst@redhat.com>
	<20090811212802.GC26309@redhat.com> <4A82076A.1060805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A82076A.1060805@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, netdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 11, 2009 at 08:06:02PM -0400, Gregory Haskins wrote:
> > diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> > index 0521177..781a8bb 100644
> > --- a/include/linux/miscdevice.h
> > +++ b/include/linux/miscdevice.h
> > @@ -30,6 +30,7 @@
> >  #define HPET_MINOR		228
> >  #define FUSE_MINOR		229
> >  #define KVM_MINOR		232
> > +#define VHOST_NET_MINOR		233
> 
> Would recommend using DYNAMIC-MINOR.

Good idea. Thanks!

-- 
MST
