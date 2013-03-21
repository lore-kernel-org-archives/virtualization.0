From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 19:13:19 +0200
Message-ID: <20130321171319.GD2994@redhat.com>
References: <20130321151937.GB1454@redhat.com> <514B26BC.6010700@zytor.com>
	<20130321155810.GA1925@redhat.com> <514B2FA0.9000204@zytor.com>
	<20130321161143.GC1925@redhat.com> <514B3213.8070002@zytor.com>
	<20130321162636.GF1925@redhat.com> <514B3606.2090503@zytor.com>
	<20130321170706.GB2994@redhat.com> <514B3EAE.8000707@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <514B3EAE.8000707@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 10:09:02AM -0700, H. Peter Anvin wrote:
> On 03/21/2013 10:07 AM, Michael S. Tsirkin wrote:
> > 
> > I just think it does not apply to BIOS so much.  A bigger issue for BIOS
> > virtio performance is that it normally does not implement batching at
> > all, to keep it simple and reduce memory usage it uses a small number
> > (often 1) of outstanding buffers per queue.
> > 
> 
> You asked for examples, so I gave one.  There is no doubt that BIOS can
> make use of this if available.
> 
> What you describe above is of course a typical problem with BIOS.
> 
> 	-hpa

Right, thanks.
Also thanks for the spec quote, I really think we should add the config
cycle access as a guaranteed feature.  It's easy and I expect all BIOS
drivers to use it.

-- 
MST
