From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 10:09:02 -0700
Message-ID: <514B3EAE.8000707@zytor.com>
References: <20130321144330.GA1454@redhat.com> <514B1D25.9090206@zytor.com>
	<20130321151937.GB1454@redhat.com> <514B26BC.6010700@zytor.com>
	<20130321155810.GA1925@redhat.com> <514B2FA0.9000204@zytor.com>
	<20130321161143.GC1925@redhat.com> <514B3213.8070002@zytor.com>
	<20130321162636.GF1925@redhat.com> <514B3606.2090503@zytor.com>
	<20130321170706.GB2994@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130321170706.GB2994@redhat.com>
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

On 03/21/2013 10:07 AM, Michael S. Tsirkin wrote:
> 
> I just think it does not apply to BIOS so much.  A bigger issue for BIOS
> virtio performance is that it normally does not implement batching at
> all, to keep it simple and reduce memory usage it uses a small number
> (often 1) of outstanding buffers per queue.
> 

You asked for examples, so I gave one.  There is no doubt that BIOS can
make use of this if available.

What you describe above is of course a typical problem with BIOS.

	-hpa
