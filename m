From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Sun, 24 Mar 2013 16:23:57 -0700
Message-ID: <514F8B0D.7000400@zytor.com>
References: <20130321161143.GC1925@redhat.com> <514B3213.8070002@zytor.com>
	<20130321162636.GF1925@redhat.com> <514B3606.2090503@zytor.com>
	<20130321170706.GB2994@redhat.com> <514B3EAE.8000707@zytor.com>
	<20130321171319.GD2994@redhat.com>
	<20130321174912.GA4161@redhat.com> <514B4957.1070003@zytor.com>
	<8738vofdyg.fsf@rustcorp.com.au> <20130324131408.GD6601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130324131408.GD6601@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/24/2013 06:14 AM, Michael S. Tsirkin wrote:
> 
> Peter is also saying we need a way to
> do configuration/ISR without memory accesses.
> 

I'm not 100% sure what you mean with ISR here (mostly because virtio
only has a limited fraction of my attention right now.)

For configuration, are we dealing with too much data to just put it in
configuration space?

	-hpa
