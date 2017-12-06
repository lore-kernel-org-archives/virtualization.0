From: "Cherian, George" <George.Cherian@cavium.com>
Subject: Re: [PATCH] ptr_ring: Add barriers to fix NULL-pointer exception
Date: Wed, 6 Dec 2017 14:08:54 +0000
Message-ID: <BN3PR0701MB1702F47F81C945950E284DE0F9320@BN3PR0701MB1702.namprd07.prod.outlook.com>
References: <1512554261-5030-1-git-send-email-george.cherian@cavium.com>,
	<20171206153349-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3183049704903991173=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171206153349-mutt-send-email-mst@kernel.org>
Content-Language: en-US
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

--===============3183049704903991173==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN3PR0701MB1702F47F81C945950E284DE0F9320BN3PR0701MB1702_"

--_000_BN3PR0701MB1702F47F81C945950E284DE0F9320BN3PR0701MB1702_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

_____________________________
From: Michael S. Tsirkin <mst@redhat.com>
Sent: Wednesday, December 6, 2017 7:05 PM
Subject: Re: [PATCH] ptr_ring: Add barriers to fix NULL-pointer exception
To: Cherian, George <george.cherian@cavium.com>
Cc: <linux-kernel@vger.kernel.org>, <davem@davemloft.net>, <jasowang@redhat=
.com>, <edumazet@google.com>, <netdev@vger.kernel.org>, <virtualization@lis=
ts.linux-foundation.org>


On Wed, Dec 06, 2017 at 09:57:41AM +0000, George Cherian wrote:
> While running a multiple VM testscase with each VM running iperf
> traffic between others the following kernel NULL pointer exception
> was seen.
>
> Race appears when the tun driver instance of one VM calls skb_array_produ=
ce
> (from tun_net_xmit) and the the destined VM's skb_array_consume
> (from tun_ring_recv), which could run concurrently on another core. Due t=
o
> which the sock_wfree gets called again from the tun_ring_recv context.
>
> The fix is to add write/read barrier calls to be sure that we get proper
> values in the tun_ring_recv context.
>
> Crash log
> [35321.580227] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000060
> [35321.596720] pgd =3D ffff809ee552f000
> [35321.603723] [00000060] *pgd=3D0000009f514ac003, *pud=3D0000009f54f7c00=
3, *pmd=3D0000000000000000
> [35321.620588] Internal error: Oops: 96000006 1 SMP
> [35321.630461] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERA=
DE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 =
nf_defrag_ipv4 xt_4
> [35321.728501] CPU: 114 PID: 5560 Comm: qemu-system-aar Not tainted 4.11.=
8-4k-vhe-lse+ #3
> [35321.744510] Hardware name: Cavium Inc. Unknown/Unknown, BIOS 1.0 07/24=
/2017
> [35321.758602] task: ffff80bed7fca880 task.stack: ffff80beb5128000
> [35321.770600] PC is at sock_wfree+0x24/0x80
> [35321.778746] LR is at skb_release_head_state+0x68/0xf8
> [35321.788979] pc : [<ffff000008a772fc>] lr : [<ffff000008a79238>] pstate=
: 40400149
> [35321.803930] sp : ffff80beb512bc30
> [35321.810648] x29: ffff80beb512bc30 x28: ffff80bed7fca880
> [35321.821400] x27: 000000000000004e x26: 0000000000000000
> [35321.832156] x25: 000000000000000c x24: 0000000000000000
> [35321.842947] x23: ffff809ece3e4900 x22: ffff80beb512be00
> [35321.853729] x21: ffff000009138000 x20: 0000000000000144
> [35321.864507] x19: 0000000000000000 x18: 0000000000000014
> [35321.875276] x17: 0000ffff9d9689a0 x16: ffff00000828b3f8
> [35321.886048] x15: 0000504d7b000000 x14: e90ab50c48680a08
> [35321.896824] x13: 0101000017773f52 x12: 1080d422c00e5db6
> [35321.907595] x11: 68c322bd3930cf7a x10: a8c0d07aa8c0ad16
> [35321.918352] x9 : 000000001da4ed90 x8 : b50c48680a080101
> [35321.929099] x7 : 000017770c521080 x6 : 000000001d6c13f2
> [35321.939865] x5 : 000000001d6c13f2 x4 : 000000000000000e
> [35321.950619] x3 : 000000085ff97d82 x2 : 0000000000000000
> [35321.961376] x1 : ffff000008a772d8 x0 : 0000000000000500
> [35321.975193] Process qemu-system-aar (pid: 5560, stack limit =3D 0xffff=
80beb5128000)
> [35321.990347] Stack: (0xffff80beb512bc30 to 0xffff80beb512c000)
> [35322.001982] bc20: ffff80beb512bc50 ffff000008a79238
> [35322.017817] bc40: ffff809e8fd7be00 000000000000004e ffff80beb512bc70 f=
fff000008a79488
> [35322.033651] bc60: ffff809e8fd7be00 ffff00000881307c ffff80beb512bc90 f=
fff000008a79678
> [35322.049489] bc80: ffff809e8fd7be00 ffff80beb512be00 ffff80beb512bcb0 f=
fff000008812f24
> [35322.065321] bca0: ffff809e8fd7be00 000000000000004e ffff80beb512bd50 f=
fff0000088133f0
> [35322.081165] bcc0: ffff809ece3e4900 0000000000011000 ffff80beb512bdd8 f=
fff80beb512be00
> [35322.097001] bce0: 000000001d6c13a4 0000000000000015 0000000000000124 0=
00000000000003f
> [35322.112866] bd00: ffff000008bc2000 ffff00000847b5ac 0000000000020000 f=
fff80be00080000
> [35322.128701] bd20: 0022000000000001 ffff80bed7fc0010 ffff000008100c38 0=
000000000000000
> [35322.144539] bd40: 0000000000000000 0000000000040b08 ffff80beb512bd80 f=
fff000008288f80
> [35322.160395] bd60: ffff000009138000 ffff809ee7cd3500 0000000000011000 f=
fff80beb512beb0
> [35322.176255] bd80: ffff80beb512be30 ffff00000828a224 0000000000011000 f=
fff809ee7cd3500
> [35322.192109] bda0: 000000001d6c13a4 ffff80beb512beb0 0000000000011000 0=
000000000000000
> [35322.207974] bdc0: 0000000000000000 000000001d6c13a4 0000000000011000 f=
fff809ee7cd3500
> [35322.223822] bde0: 000000000000004e 0000000000000000 0000000000000000 0=
000000000000000
> [35322.239661] be00: ffff80be00000000 000000000000004e 0000000000010fb2 f=
fff80beb512bdc8
> [35322.255519] be20: 0000000000000001 0000000000040b08 ffff80beb512be70 f=
fff00000828b464
> [35322.271392] be40: ffff000009138000 ffff809ee7cd3501 ffff809ee7cd3500 0=
00000001d6c13a4
> [35322.287255] be60: 0000000000011000 0000000000000015 0000000000000000 f=
fff0000080833f0
> [35322.303090] be80: 0000000000000000 000080bef0071000 ffffffffffffffff 0=
000ffff9d9689cc
> [35322.318951] bea0: 0000000080000000 000080bef0071000 000000000000004e 0=
000000000040b08
> [35322.334771] bec0: 000000000000000e 000000001d6c13a4 0000000000011000 0=
000ffff9cc89108
> [35322.350640] bee0: 0000000000000002 0000ffff9cc89000 0000ffff9cc896f0 0=
000000000000000
> [35322.366500] bf00: 000000000000003f 000000001da4ed90 a8c0d07aa8c0ad16 6=
8c322bd3930cf7a
> [35322.382358] bf20: 1080d422c00e5db6 0101000017773f52 e90ab50c48680a08 0=
000504d7b000000
> [35322.398209] bf40: 0000000000000000 0000ffff9d9689a0 0000000000000014 0=
000000000000030
> [35322.414063] bf60: 000000001d6c13a4 000000001d6c0db0 000000001d6d1db0 0=
0000000006fbbc8
> [35322.429901] bf80: 0000000000011000 000000001d6ab3e8 000000001d6ab3a4 0=
0000000007ee4c8
> [35322.445751] bfa0: 0000000000000000 0000fffff363ab70 0000ffff9d9689b8 0=
000fffff363ab30
> [35322.461588] bfc0: 0000ffff9d9689cc 0000000080000000 000000000000000e 0=
00000000000003f
> [35322.477445] bfe0: 0000000000000000 0000000000000000 ffff809ed043d758 0=
000000000000000
> [35322.493283] Call trace:
> [35322.498275] Exception stack(0xffff80beb512ba40 to 0xffff80beb512bb70)
> [35322.511303] ba40: 0000000000000000 0001000000000000 ffff80beb512bc30 f=
fff000008a772fc
> [35322.527152] ba60: 0000000040400149 0000000000000049 ffff000008bc2000 f=
fff80bed7fca880
> [35322.542992] ba80: 0000000000000000 0000000000000000 0000000000000000 0=
000000000000000
> [35322.558863] baa0: 0000000000000000 000000001d895758 ffff80beb512bb78 0=
000000000000000
> [35322.574702] bac0: 000000050000000b 0000000800000001 0000000a00000001 0=
000000b00000001
> [35322.590550] bae0: 0000000e00000001 0000001800010001 ffff80beb512bbf0 0=
000000000040b08
> [35322.606416] bb00: 0000000000000500 ffff000008a772d8 0000000000000000 0=
00000085ff97d82
> [35322.622287] bb20: 000000000000000e 000000001d6c13f2 000000001d6c13f2 0=
00017770c521080
> [35322.638144] bb40: b50c48680a080101 000000001da4ed90 a8c0d07aa8c0ad16 6=
8c322bd3930cf7a
> [35322.653992] bb60: 1080d422c00e5db6 0101000017773f52
> [35322.663908] [<ffff000008a772fc>] sock_wfree+0x24/0x80
> [35322.674168] [<ffff000008a79238>] skb_release_head_state+0x68/0xf8
> [35322.686535] [<ffff000008a79488>] skb_release_all+0x20/0x40
> [35322.697663] [<ffff000008a79678>] consume_skb+0x38/0xd8
> [35322.708120] [<ffff000008812f24>] tun_do_read.part.9+0x20c/0x4f0
> [35322.720149] [<ffff0000088133f0>] tun_chr_read_iter+0xc0/0xe0
> [35322.731638] [<ffff000008288f80>] __vfs_read+0x100/0x160
> [35322.742249] [<ffff00000828a224>] vfs_read+0x8c/0x148
> [35322.752344] [<ffff00000828b464>] SyS_read+0x6c/0xd8
> [35322.762263] [<ffff0000080833f0>] el0_svc_naked+0x24/0x28
> [35322.773042] Code: d503201f f9400e93 b940e280 91051274 (f9403261)
>
> Reported-by: Joseph DeVincentis <Joseph.DeVincentis@cavium.com>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
> include/linux/ptr_ring.h | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 37b4bb2..bc3b36b 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -106,6 +106,12 @@ static inline int __ptr_ring_produce(struct ptr_ring=
 *r, void *ptr)
> {
> if (unlikely(!r->size) || r->queue[r->producer])
> return -ENOSPC;
> + /*
> + * This barrier is necessary in order to prevent race condition with
> + * with __ptr_ring_consume(). By this we make sure all the prior
> + * writes to *ptr elements are updated.
> + */
> + wmb();
>
> r->queue[r->producer++] =3D ptr;
> if (unlikely(r->producer >=3D r->size))
> @@ -275,6 +281,13 @@ static inline void *__ptr_ring_consume(struct ptr_ri=
ng *r)
> if (ptr)
> __ptr_ring_discard_one(r);
>
> + /*
> + * This barrier is necessary in order to prevent race condition with
> + * with __ptr_ring_produce(). Make sure all the elements of ptr is
> + * in sync with the earlier writes which was done prior to pushing
> + * it to ring
> + */
> + rmb();
> return ptr;
> }

You are trying to synchronise two CPUs so non-smp barriers make no
sense. wmb/rmb are for synchronising with MMIO.

What happens when CONFIG_SMP is not set. smp_wmb/rmb becomes compiler barri=
ers(atleast for arm64). I guess that is not what we need. An SMP barrier ca=
nnot replace a mandatory barrier, but a mandatory barrier can replace an SM=
P barrier.

I will try out your patch too and update the results.
But I would need couple of days time. Sorry for the delay.


> --
> 2.1.4



--_000_BN3PR0701MB1702F47F81C945950E284DE0F9320BN3PR0701MB1702_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!-- This file has been automatically generated. See web/README.md -->
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div id=3D"compose-container" style=3D"direction: ltr" itemscope=3D"" itemt=
ype=3D"https://schema.org/EmailMessage">
<span itemprop=3D"creator" itemscope=3D"" itemtype=3D"https://schema.org/Or=
ganization"><span itemprop=3D"name" content=3D"Outlook Mobile for iOS"></sp=
an></span>
<div>
<div style=3D"direction: ltr;">Hi Michael,</div>
<div><br>
</div>
<div class=3D"gmail_quote">_____________________________<br>
From: Michael S. Tsirkin &lt;mst@redhat.com&gt;<br>
Sent: Wednesday, December 6, 2017 7:05 PM<br>
Subject: Re: [PATCH] ptr_ring: Add barriers to fix NULL-pointer exception<b=
r>
To: Cherian, George &lt;george.cherian@cavium.com&gt;<br>
Cc: &lt;linux-kernel@vger.kernel.org&gt;, &lt;davem@davemloft.net&gt;, &lt;=
jasowang@redhat.com&gt;, &lt;edumazet@google.com&gt;, &lt;netdev@vger.kerne=
l.org&gt;, &lt;virtualization@lists.linux-foundation.org&gt;<br>
<br>
<br>
On Wed, Dec 06, 2017 at 09:57:41AM &#43;0000, George Cherian wrote:<br>
&gt; While running a multiple VM testscase with each VM running iperf<br>
&gt; traffic between others the following kernel NULL pointer exception<br>
&gt; was seen.<br>
&gt; <br>
&gt; Race appears when the tun driver instance of one VM calls skb_array_pr=
oduce<br>
&gt; (from tun_net_xmit) and the the destined VM's skb_array_consume<br>
&gt; (from tun_ring_recv), which could run concurrently on another core. Du=
e to<br>
&gt; which the sock_wfree gets called again from the tun_ring_recv context.=
<br>
&gt; <br>
&gt; The fix is to add write/read barrier calls to be sure that we get prop=
er<br>
&gt; values in the tun_ring_recv context.<br>
&gt; <br>
&gt; Crash log<br>
&gt; [35321.580227] Unable to handle kernel NULL pointer dereference at vir=
tual address 00000060<br>
&gt; [35321.596720] pgd =3D ffff809ee552f000<br>
&gt; [35321.603723] [00000060] *pgd=3D0000009f514ac003, *pud=3D0000009f54f7=
c003, *pmd=3D0000000000000000<br>
&gt; [35321.620588] Internal error: Oops: 96000006 1 SMP<br>
&gt; [35321.630461] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQU=
ERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ip=
v4 nf_defrag_ipv4 xt_4<br>
&gt; [35321.728501] CPU: 114 PID: 5560 Comm: qemu-system-aar Not tainted 4.=
11.8-4k-vhe-lse&#43; #3<br>
&gt; [35321.744510] Hardware name: Cavium Inc. Unknown/Unknown, BIOS 1.0 07=
/24/2017<br>
&gt; [35321.758602] task: ffff80bed7fca880 task.stack: ffff80beb5128000<br>
&gt; [35321.770600] PC is at sock_wfree&#43;0x24/0x80<br>
&gt; [35321.778746] LR is at skb_release_head_state&#43;0x68/0xf8<br>
&gt; [35321.788979] pc : [&lt;ffff000008a772fc&gt;] lr : [&lt;ffff000008a79=
238&gt;] pstate: 40400149<br>
&gt; [35321.803930] sp : ffff80beb512bc30<br>
&gt; [35321.810648] x29: ffff80beb512bc30 x28: ffff80bed7fca880<br>
&gt; [35321.821400] x27: 000000000000004e x26: 0000000000000000<br>
&gt; [35321.832156] x25: 000000000000000c x24: 0000000000000000<br>
&gt; [35321.842947] x23: ffff809ece3e4900 x22: ffff80beb512be00<br>
&gt; [35321.853729] x21: ffff000009138000 x20: 0000000000000144<br>
&gt; [35321.864507] x19: 0000000000000000 x18: 0000000000000014<br>
&gt; [35321.875276] x17: 0000ffff9d9689a0 x16: ffff00000828b3f8<br>
&gt; [35321.886048] x15: 0000504d7b000000 x14: e90ab50c48680a08<br>
&gt; [35321.896824] x13: 0101000017773f52 x12: 1080d422c00e5db6<br>
&gt; [35321.907595] x11: 68c322bd3930cf7a x10: a8c0d07aa8c0ad16<br>
&gt; [35321.918352] x9 : 000000001da4ed90 x8 : b50c48680a080101<br>
&gt; [35321.929099] x7 : 000017770c521080 x6 : 000000001d6c13f2<br>
&gt; [35321.939865] x5 : 000000001d6c13f2 x4 : 000000000000000e<br>
&gt; [35321.950619] x3 : 000000085ff97d82 x2 : 0000000000000000<br>
&gt; [35321.961376] x1 : ffff000008a772d8 x0 : 0000000000000500<br>
&gt; [35321.975193] Process qemu-system-aar (pid: 5560, stack limit =3D 0xf=
fff80beb5128000)<br>
&gt; [35321.990347] Stack: (0xffff80beb512bc30 to 0xffff80beb512c000)<br>
&gt; [35322.001982] bc20: ffff80beb512bc50 ffff000008a79238<br>
&gt; [35322.017817] bc40: ffff809e8fd7be00 000000000000004e ffff80beb512bc7=
0 ffff000008a79488<br>
&gt; [35322.033651] bc60: ffff809e8fd7be00 ffff00000881307c ffff80beb512bc9=
0 ffff000008a79678<br>
&gt; [35322.049489] bc80: ffff809e8fd7be00 ffff80beb512be00 ffff80beb512bcb=
0 ffff000008812f24<br>
&gt; [35322.065321] bca0: ffff809e8fd7be00 000000000000004e ffff80beb512bd5=
0 ffff0000088133f0<br>
&gt; [35322.081165] bcc0: ffff809ece3e4900 0000000000011000 ffff80beb512bdd=
8 ffff80beb512be00<br>
&gt; [35322.097001] bce0: 000000001d6c13a4 0000000000000015 000000000000012=
4 000000000000003f<br>
&gt; [35322.112866] bd00: ffff000008bc2000 ffff00000847b5ac 000000000002000=
0 ffff80be00080000<br>
&gt; [35322.128701] bd20: 0022000000000001 ffff80bed7fc0010 ffff000008100c3=
8 0000000000000000<br>
&gt; [35322.144539] bd40: 0000000000000000 0000000000040b08 ffff80beb512bd8=
0 ffff000008288f80<br>
&gt; [35322.160395] bd60: ffff000009138000 ffff809ee7cd3500 000000000001100=
0 ffff80beb512beb0<br>
&gt; [35322.176255] bd80: ffff80beb512be30 ffff00000828a224 000000000001100=
0 ffff809ee7cd3500<br>
&gt; [35322.192109] bda0: 000000001d6c13a4 ffff80beb512beb0 000000000001100=
0 0000000000000000<br>
&gt; [35322.207974] bdc0: 0000000000000000 000000001d6c13a4 000000000001100=
0 ffff809ee7cd3500<br>
&gt; [35322.223822] bde0: 000000000000004e 0000000000000000 000000000000000=
0 0000000000000000<br>
&gt; [35322.239661] be00: ffff80be00000000 000000000000004e 0000000000010fb=
2 ffff80beb512bdc8<br>
&gt; [35322.255519] be20: 0000000000000001 0000000000040b08 ffff80beb512be7=
0 ffff00000828b464<br>
&gt; [35322.271392] be40: ffff000009138000 ffff809ee7cd3501 ffff809ee7cd350=
0 000000001d6c13a4<br>
&gt; [35322.287255] be60: 0000000000011000 0000000000000015 000000000000000=
0 ffff0000080833f0<br>
&gt; [35322.303090] be80: 0000000000000000 000080bef0071000 fffffffffffffff=
f 0000ffff9d9689cc<br>
&gt; [35322.318951] bea0: 0000000080000000 000080bef0071000 000000000000004=
e 0000000000040b08<br>
&gt; [35322.334771] bec0: 000000000000000e 000000001d6c13a4 000000000001100=
0 0000ffff9cc89108<br>
&gt; [35322.350640] bee0: 0000000000000002 0000ffff9cc89000 0000ffff9cc896f=
0 0000000000000000<br>
&gt; [35322.366500] bf00: 000000000000003f 000000001da4ed90 a8c0d07aa8c0ad1=
6 68c322bd3930cf7a<br>
&gt; [35322.382358] bf20: 1080d422c00e5db6 0101000017773f52 e90ab50c48680a0=
8 0000504d7b000000<br>
&gt; [35322.398209] bf40: 0000000000000000 0000ffff9d9689a0 000000000000001=
4 0000000000000030<br>
&gt; [35322.414063] bf60: 000000001d6c13a4 000000001d6c0db0 000000001d6d1db=
0 00000000006fbbc8<br>
&gt; [35322.429901] bf80: 0000000000011000 000000001d6ab3e8 000000001d6ab3a=
4 00000000007ee4c8<br>
&gt; [35322.445751] bfa0: 0000000000000000 0000fffff363ab70 0000ffff9d9689b=
8 0000fffff363ab30<br>
&gt; [35322.461588] bfc0: 0000ffff9d9689cc 0000000080000000 000000000000000=
e 000000000000003f<br>
&gt; [35322.477445] bfe0: 0000000000000000 0000000000000000 ffff809ed043d75=
8 0000000000000000<br>
&gt; [35322.493283] Call trace:<br>
&gt; [35322.498275] Exception stack(0xffff80beb512ba40 to 0xffff80beb512bb7=
0)<br>
&gt; [35322.511303] ba40: 0000000000000000 0001000000000000 ffff80beb512bc3=
0 ffff000008a772fc<br>
&gt; [35322.527152] ba60: 0000000040400149 0000000000000049 ffff000008bc200=
0 ffff80bed7fca880<br>
&gt; [35322.542992] ba80: 0000000000000000 0000000000000000 000000000000000=
0 0000000000000000<br>
&gt; [35322.558863] baa0: 0000000000000000 000000001d895758 ffff80beb512bb7=
8 0000000000000000<br>
&gt; [35322.574702] bac0: 000000050000000b 0000000800000001 0000000a0000000=
1 0000000b00000001<br>
&gt; [35322.590550] bae0: 0000000e00000001 0000001800010001 ffff80beb512bbf=
0 0000000000040b08<br>
&gt; [35322.606416] bb00: 0000000000000500 ffff000008a772d8 000000000000000=
0 000000085ff97d82<br>
&gt; [35322.622287] bb20: 000000000000000e 000000001d6c13f2 000000001d6c13f=
2 000017770c521080<br>
&gt; [35322.638144] bb40: b50c48680a080101 000000001da4ed90 a8c0d07aa8c0ad1=
6 68c322bd3930cf7a<br>
&gt; [35322.653992] bb60: 1080d422c00e5db6 0101000017773f52<br>
&gt; [35322.663908] [&lt;ffff000008a772fc&gt;] sock_wfree&#43;0x24/0x80<br>
&gt; [35322.674168] [&lt;ffff000008a79238&gt;] skb_release_head_state&#43;0=
x68/0xf8<br>
&gt; [35322.686535] [&lt;ffff000008a79488&gt;] skb_release_all&#43;0x20/0x4=
0<br>
&gt; [35322.697663] [&lt;ffff000008a79678&gt;] consume_skb&#43;0x38/0xd8<br=
>
&gt; [35322.708120] [&lt;ffff000008812f24&gt;] tun_do_read.part.9&#43;0x20c=
/0x4f0<br>
&gt; [35322.720149] [&lt;ffff0000088133f0&gt;] tun_chr_read_iter&#43;0xc0/0=
xe0<br>
&gt; [35322.731638] [&lt;ffff000008288f80&gt;] __vfs_read&#43;0x100/0x160<b=
r>
&gt; [35322.742249] [&lt;ffff00000828a224&gt;] vfs_read&#43;0x8c/0x148<br>
&gt; [35322.752344] [&lt;ffff00000828b464&gt;] SyS_read&#43;0x6c/0xd8<br>
&gt; [35322.762263] [&lt;ffff0000080833f0&gt;] el0_svc_naked&#43;0x24/0x28<=
br>
&gt; [35322.773042] Code: d503201f f9400e93 b940e280 91051274 (f9403261)<br=
>
&gt; <br>
&gt; Reported-by: Joseph DeVincentis &lt;Joseph.DeVincentis@cavium.com&gt;<=
br>
&gt; Signed-off-by: George Cherian &lt;george.cherian@cavium.com&gt;<br>
&gt; ---<br>
&gt; include/linux/ptr_ring.h | 13 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;<br>
&gt; 1 file changed, 13 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h<br>
&gt; index 37b4bb2..bc3b36b 100644<br>
&gt; --- a/include/linux/ptr_ring.h<br>
&gt; &#43;&#43;&#43; b/include/linux/ptr_ring.h<br>
&gt; @@ -106,6 &#43;106,12 @@ static inline int __ptr_ring_produce(struct p=
tr_ring *r, void *ptr)<br>
&gt; {<br>
&gt; if (unlikely(!r-&gt;size) || r-&gt;queue[r-&gt;producer])<br>
&gt; return -ENOSPC;<br>
&gt; &#43; /*<br>
&gt; &#43; * This barrier is necessary in order to prevent race condition w=
ith<br>
&gt; &#43; * with __ptr_ring_consume(). By this we make sure all the prior<=
br>
&gt; &#43; * writes to *ptr elements are updated.<br>
&gt; &#43; */<br>
&gt; &#43; wmb();<br>
&gt; <br>
&gt; r-&gt;queue[r-&gt;producer&#43;&#43;] =3D ptr;<br>
&gt; if (unlikely(r-&gt;producer &gt;=3D r-&gt;size))<br>
&gt; @@ -275,6 &#43;281,13 @@ static inline void *__ptr_ring_consume(struct=
 ptr_ring *r)<br>
&gt; if (ptr)<br>
&gt; __ptr_ring_discard_one(r);<br>
&gt; <br>
&gt; &#43; /*<br>
&gt; &#43; * This barrier is necessary in order to prevent race condition w=
ith<br>
&gt; &#43; * with __ptr_ring_produce(). Make sure all the elements of ptr i=
s<br>
&gt; &#43; * in sync with the earlier writes which was done prior to pushin=
g<br>
&gt; &#43; * it to ring<br>
&gt; &#43; */<br>
&gt; &#43; rmb();<br>
&gt; return ptr;<br>
&gt; }<br>
<br>
You are trying to synchronise two CPUs so non-smp barriers make no<br>
sense. wmb/rmb are for synchronising with MMIO.</div>
<div class=3D"gmail_quote"><br>
</div>
<div class=3D"gmail_quote">What happens when CONFIG_SMP is not set. smp_wmb=
/rmb becomes compiler barriers(atleast for arm64). I guess that is not what=
 we need. An SMP barrier cannot replace a mandatory barrier, but a mandator=
y barrier can replace an SMP barrier.</div>
<div class=3D"gmail_quote"><br>
</div>
<div class=3D"gmail_quote" style=3D"direction: ltr;">I will try out your pa=
tch too and update the results.</div>
<div class=3D"gmail_quote" style=3D"direction: ltr;">But I would need coupl=
e of days time. Sorry for the delay.</div>
<div class=3D"gmail_quote"><br>
</div>
<div class=3D"gmail_quote" style=3D"direction: ltr;"><br>
&gt; -- <br>
&gt; 2.1.4<br>
<br>
<br>
</div>
</div>
</div>
</body>
</html>

--_000_BN3PR0701MB1702F47F81C945950E284DE0F9320BN3PR0701MB1702_--

--===============3183049704903991173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3183049704903991173==--
