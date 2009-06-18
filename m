From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCHv5 08/13] qemu: add support for resizing
	regions
Date: Thu, 18 Jun 2009 17:32:11 +0100
Message-ID: <200906181735.10458.paul__18455.5650492714$1245343159$gmane$org@codesourcery.com>
References: <cover.1245330293.git.mst@redhat.com>
	<20090618131438.GI19092@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090618131438.GI19092@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 18 June 2009, Michael S. Tsirkin wrote:
> Make it possible to resize PCI regions.  This will be used by virtio
> with MSI-X, where the region size depends on whether MSI-X is enabled,
> and can change across load/save.

I thought we'd agreed we shouldn't be doing this.
i.e. if the user tries to load the wrong device, just bail out.

Paul
