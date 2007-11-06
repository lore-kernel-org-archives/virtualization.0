From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Use of virtio device IDs
Date: Tue, 06 Nov 2007 11:16:10 -0600
Message-ID: <4730A15A.6070001__14581.5693228089$1194369518$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

I've written a PCI virtio transport and noticed something strange.  All 
current in-tree virtio devices register ID tables that match a specific 
device ID, but any vendor ID.

This is incompatible with using PCI vendor/device IDs for virtio 
vendor/device IDs since vendors control what device IDs mean.  A simple 
solution would be to assign a fixed vendor ID to all current virtio 
devices.  This doesn't solve the problem completely though since you 
would create a conflict between the PCI vendor ID space and the virtio 
vendor ID space.

The only solutions seem to be virtualizing the virtio vendor/device IDs 
(which is what I'm currently doing) or to mandate that the virtio vendor 
ID be within the PCI vendor ID space.  It's probably not necessary to 
make the same requirement for device IDs though.

What are your thoughts?

Regards,

Anthony Liguori
