From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [REGRESSION] 07ec51480b5e ("virtio_pci: use shared interrupts for
	virtqueues") causes crashes in guest
Date: Thu, 23 Mar 2017 18:15:08 +0100
Message-ID: <a4a174ed-cfd6-2f56-d208-3c446fe46462__48745.7536547028$1493076868$gmane$org@leemhuis.info>
References: <43ffa887-a20d-f836-cba8-11196924d82d@redhat.com>
	<e042635f-e30e-45e8-f4a5-b03b9228eec2@redhat.com>
	<20170323151906.GA19376@redhat.com>
	<20170323184143-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170323184143-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: Laura Abbott <labbott@redhat.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 23.03.2017 17:41, Michael S. Tsirkin wrote:
> On Thu, Mar 23, 2017 at 03:19:07PM +0000, Richard W.M. Jones wrote:
>> On Thu, Mar 23, 2017 at 01:13:50PM +0800, Jason Wang wrote:
>>> >From 312859b596e83a2164a8430343d31fce2a5ad808 Mon Sep 17 00:00:00 2001
>>> From: Jason Wang <jasowang@redhat.com>
>>> Date: Thu, 23 Mar 2017 13:07:16 +0800
>>> Subject: [PATCH] virtio_pci: fix out of bound access for msix_names
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> I tested this, and it does appear to fix the crashes in
>> vp_modern_find_vqs.  Therefore:
>> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> I've queued the fix, thanks everyone!

Thx. Feel free to add

Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

as a kernel with that patch works well in my reboot tests so far.
 Ciao, Thorsten
