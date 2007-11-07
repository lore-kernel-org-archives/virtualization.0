From: Gregory Haskins <gregory.haskins.ml@gmail.com>
Subject: Re: Use of virtio device IDs
Date: Tue, 06 Nov 2007 22:38:50 -0500
Message-ID: <4731334A.6090405__20770.3880420469$1194450786$gmane$org@gmail.com>
References: <4730A15A.6070001@us.ibm.com> <4730B753.2000901@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4730B753.2000901@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:

> 
> Right now, we would have to have every PCI vendor/device ID pair in the
> virtio PCI driver ID table for every virtio device.

I realize you guys are probably far down this road in the design
process, but FWIW: This is a major motivation for the reason that the
IOQ stuff I posted a while back used strings for device identification
instead of a fixed length, centrally managed namespace like PCI
vendor/dev-id.  Then you can just name your device something reasonably
unique (e.g. "qumranet::veth", or "ibm-pvirt-clock").

(I realize that if you are going to do PCI, you need to make it
PCI-like.  But I think using PCI in the first place is probably the
wrong direction.  IMHO, there's really not a lot of reason to be
constrained by a hardware specification once you decide to go PV.  This
is even more true if you want to support as many platforms as possible
(i.e. platforms that don't have PCI natively).

Regards,
-Greg
