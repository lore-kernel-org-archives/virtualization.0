From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at
	net/core/flow_dissector.c:764 __skb_flow_dissect
Date: Fri, 21 Dec 2018 09:42:36 -0500
Message-ID: <CAF=yD-KCD1jwX-eBSfy9PTK3G8ZFkFh+Ysnj+YuHTbtAcRjPBw__35828.3509653576$1545403273$gmane$org@mail.gmail.com>
References: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com>
	<20181220091207.GA25942@splinter>
	<0c5a8fa8-efb3-71f2-0da9-6fc0f133cdf9@de.ibm.com>
	<20181220141752.GB861@splinter>
	<CAF=yD-KBkX3NxtDt6mv-PoujFfdtJJ66XsnGzx-KQop6EU6LRw@mail.gmail.com>
	<e25104e5-4385-965c-993c-85952db254c9@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e25104e5-4385-965c-993c-85952db254c9@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Willem de Bruijn <willemb@google.com>, Michael S Tsirkin <mst@redhat.com>, Network Development <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ido Schimmel <idosch@idosch.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 21, 2018 at 1:45 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 20.12.2018 18:23, Willem de Bruijn wrote:
> > On Thu, Dec 20, 2018 at 11:17 AM Ido Schimmel <idosch@idosch.org> wrote:
> >>
> >> On Thu, Dec 20, 2018 at 03:09:22PM +0100, Christian Borntraeger wrote:
> >>> On 20.12.2018 10:12, Ido Schimmel wrote:
> >>>> +Willem
> >>>>
> >>>> On Thu, Dec 20, 2018 at 08:45:40AM +0100, Christian Borntraeger wrote:
> >>>>> Folks,
> >>>>>
> >>>>> I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
> >>>>> Maybe someone has a quick idea.
> >>>>>
> >>>>> [85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318
> >>>>
> >>>> I managed to trigger this warning as well the other day, but from a
> >>>> different call path:
> >>>
> >>> FWIW, it also seems to happen on 4.20-rc1. 4.19.0 seems fine. bisect seem to have failed so
> >>> my reproducer is not reliable.
> >>
> >> Yes, it is caused by commit d0e13a1488ad ("flow_dissector: lookup netns
> >> by skb->sk if skb->dev is NULL")
> >>
> >> $ git tag --contains d0e13a1488ad
> >> v4.20-rc1
> >> v4.20-rc2
> >> v4.20-rc3
> >> v4.20-rc4
> >> v4.20-rc5
> >> v4.20-rc6
> >
> > That tap_get_user_xdp path is also new for 4.20-rc1:
> >
> >     commit 0efac27791ee068075d80f07c55a229b1335ce12
> >     tap: accept an array of XDP buffs through sendmsg()
> >
> >     $ git describe --contains 0efac27791ee
> >     v4.20-rc1~14^2~382^2~1
> >
> > In v4.19 and before all packets went through tap_get_user.
>
> Hmmm, so maybe my bisect wasnt broken at all? It pointed to
>
> commit 105bc1306e9b29c2aa2783b9524f7aec9b5a5b1f
> Merge: 3475372ff60e4 d0e13a1488ad3
> Author:     David S. Miller <davem@davemloft.net>
> AuthorDate: Tue Sep 25 20:29:38 2018 -0700
> Commit:     David S. Miller <davem@davemloft.net>
> CommitDate: Tue Sep 25 20:29:38 2018 -0700
>
>     Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next

Yes, that's the right commit. The flow dissector change went in
through bpf-next.
