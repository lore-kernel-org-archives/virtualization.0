From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/11] qemu: helper routines for pci access.
Date: Tue, 26 May 2009 11:49:29 +0300
Message-ID: <20090526084929.GA8588__28770.6363517374$1243328015$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<20090525122533.GE5046@redhat.com>
	<20090526023337.GF13076%yamahata@valinux.co.jp>
	<20090526064152.GH6856@redhat.com> <4A1BA345.3040104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A1BA345.3040104@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Isaku Yamahata <yamahata@valinux.co.jp>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 26, 2009 at 11:07:33AM +0300, Avi Kivity wrote:
> Michael S. Tsirkin wrote:
>> On Tue, May 26, 2009 at 11:33:37AM +0900, Isaku Yamahata wrote:
>>   
>>> On Mon, May 25, 2009 at 03:25:33PM +0300, Michael S. Tsirkin wrote:
>>>     
>>>> Add inline routines for convenient access to pci devices
>>>> with correct (little) endianness. Will be used by MSI-X support.
>>>>       
>>> Just a minor comment.
>>> How about to add pci_[sg]et_byte() for consistency?
>>>     
>>
>> I don't see that it makes sense - pci_set_long(config, value)
>> is shorter than *((uint32_t *)config) = cpu_to_le32(value),
>> but single bytes don't have endianness, and *config = value
>> is shorter.
>>   
>
> It's nice to have consistent APIs though.

Well, if enough people feel so ...



qemu: add pci_get/set_byte

Add pci_get/set_byte to keep *_word and *_long access functions company.
They are unused for now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/hw/pci.h b/hw/pci.h
index 4072f16..e1e4fb4 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -263,6 +263,18 @@ PCIBus *pci_bridge_init(PCIBus *bus, int devfn, uint16_t vid, uint16_t did,
                         pci_map_irq_fn map_irq, const char *name);
 
 static inline void
+pci_set_byte(uint8_t *config, uint8_t val)
+{
+    *config = val;
+}
+
+static inline uint8_t
+pci_get_byte(uint8_t *config)
+{
+    return *config;
+}
+
+static inline void
 pci_set_word(uint8_t *config, uint16_t val)
 {
     cpu_to_le16wu((uint16_t *)config, val);

-- 
MST
