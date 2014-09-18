From: Stefan Fritsch <sf@sfritsch.de>
Subject: Re: [PATCH RFC] virtio-pci: share config interrupt between virtio
	devices
Date: Thu, 18 Sep 2014 21:18:37 +0200
Message-ID: <11860049.kd4R4PIiz4__12189.822298433$1411159167$gmane$org@k>
References: <1409550114-8186-1-git-send-email-akong@redhat.com>
	<20140901063730.GB20186@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140901063730.GB20186@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Amos Kong <akong@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 01 September 2014 09:37:30, Michael S. Tsirkin wrote:
> Why do we need INT#x?
> How about setting IRQF_SHARED for the config interrupt
> while using MSI-X? You'd have to read ISR to check that the
> interrupt was intended for your device.

The virtio 0.9.5 spec says that ISR is "unused" when in MSI-X mode. I 
don't think that you can depend on the device to set the configuration 
changed bit.

The virtio 1.0 spec seems to have fixed that.
