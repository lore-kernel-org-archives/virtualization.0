From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Mon, 25 Mar 2013 20:33:05 +1030
Message-ID: <87zjxrdcfa.fsf@rustcorp.com.au>
References: <20130321162636.GF1925@redhat.com> <514B3606.2090503@zytor.com>
	<20130321170706.GB2994@redhat.com> <514B3EAE.8000707@zytor.com>
	<20130321171319.GD2994@redhat.com>
	<20130321174912.GA4161@redhat.com> <514B4957.1070003@zytor.com>
	<8738vofdyg.fsf@rustcorp.com.au>
	<20130324131408.GD6601@redhat.com> <514F8B0D.7000400@zytor.com>
	<20130325065301.GA32581@redhat.com>
	<8a7b27e6-11f2-49c8-9ab6-c3f63c9d0460@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8a7b27e6-11f2-49c8-9ab6-c3f63c9d0460@email.android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> That might be pushing it, fitting into the 192-byte nonstandard area with everything else that might have to go there...

Yeah, and it only ever grows, since we add new fields at the end.

Cheers,
Rusty.
