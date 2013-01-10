From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Jan 10 (vmci)
Date: Thu, 10 Jan 2013 11:28:13 -0800
Message-ID: <50EF164D.9070208__5325.92619206316$1357846049$gmane$org@infradead.org>
References: <20130110143241.041ef77011ef7b1f68ae5c61@canb.auug.org.au>
	<50EF13B6.9000809@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50EF13B6.9000809@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, georgezhang@vmware.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/10/13 11:17, Randy Dunlap wrote:
> On 01/09/13 19:32, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20130109:
>>
> 
> 
> on i386, when CONFIG_PCI is not enabled:
> 
>   CC [M]  drivers/misc/vmw_vmci/vmci_guest.o
> drivers/misc/vmw_vmci/vmci_guest.c:58:20: error: array type has incomplete element type
> drivers/misc/vmw_vmci/vmci_guest.c: In function 'vmci_enable_msix':
> drivers/misc/vmw_vmci/vmci_guest.c:384:2: error: implicit declaration of function 'pci_enable_msix' [-Werror=implicit-function-declaration]
> drivers/misc/vmw_vmci/vmci_guest.c: In function 'vmci_guest_probe_device':
> drivers/misc/vmw_vmci/vmci_guest.c:466:2: error: implicit declaration of function 'pcim_enable_device' [-Werror=implicit-function-declaration]
> drivers/misc/vmw_vmci/vmci_guest.c:592:2: error: implicit declaration of function 'pci_enable_msi' [-Werror=implicit-function-declaration]
> drivers/misc/vmw_vmci/vmci_guest.c:654:3: error: implicit declaration of function 'pci_disable_msix' [-Werror=implicit-function-declaration]
> drivers/misc/vmw_vmci/vmci_guest.c:656:3: error: implicit declaration of function 'pci_disable_msi' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[4]: *** [drivers/misc/vmw_vmci/vmci_guest.o] Error 1
> 
> 
> Should all of vmci depend on PCI ??
> 
> 


Also on i386, when CONFIG_BLOCK is not enabled:

  CC [M]  drivers/misc/vmw_vmci/vmci_queue_pair.o
In file included from drivers/misc/vmw_vmci/vmci_queue_pair.c:16:0:
include/linux/device-mapper.h:48:56: warning: 'struct bio' declared inside parameter list [enabled by default]
include/linux/device-mapper.h:48:56: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
include/linux/device-mapper.h:50:13: warning: 'struct request' declared inside parameter list [enabled by default]
include/linux/device-mapper.h:61:15: warning: 'struct bio' declared inside parameter list [enabled by default]
include/linux/device-mapper.h:64:15: warning: 'struct request' declared inside parameter list [enabled by default]
include/linux/device-mapper.h:80:15: warning: 'struct bvec_merge_data' declared inside parameter list [enabled by default]
include/linux/device-mapper.h:92:12: warning: 'struct queue_limits' declared inside parameter list [enabled by default]
include/linux/device-mapper.h:265:13: error: field 'clone' has incomplete type
include/linux/device-mapper.h: In function 'dm_bio_get_target_request_nr':
include/linux/device-mapper.h:280:9: warning: initialization from incompatible pointer type [enabled by default]
include/linux/device-mapper.h: At top level:
include/linux/device-mapper.h:376:42: warning: 'struct request' declared inside parameter list [enabled by default]
include/linux/device-mapper.h:563:33: warning: 'struct request' declared inside parameter list [enabled by default]
include/linux/device-mapper.h:564:41: warning: 'struct request' declared inside parameter list [enabled by default]
include/linux/device-mapper.h:565:38: warning: 'struct request' declared inside parameter list [enabled by default]
drivers/misc/vmw_vmci/vmci_queue_pair.c: In function 'qp_alloc_ppn_set':
drivers/misc/vmw_vmci/vmci_queue_pair.c:476:6: error: implicit declaration of function 'kmalloc' [-Werror=implicit-function-declaration]
drivers/misc/vmw_vmci/vmci_queue_pair.c:475:15: warning: assignment makes pointer from integer without a cast [enabled by default]
drivers/misc/vmw_vmci/vmci_queue_pair.c:480:15: warning: assignment makes pointer from integer without a cast [enabled by default]
drivers/misc/vmw_vmci/vmci_queue_pair.c:483:3: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
drivers/misc/vmw_vmci/vmci_queue_pair.c: In function 'qp_host_alloc_queue':
drivers/misc/vmw_vmci/vmci_queue_pair.c:619:2: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
drivers/misc/vmw_vmci/vmci_queue_pair.c:619:8: warning: assignment makes pointer from integer without a cast [enabled by default]
drivers/misc/vmw_vmci/vmci_queue_pair.c: In function 'qp_release_pages':
drivers/misc/vmw_vmci/vmci_queue_pair.c:717:3: error: implicit declaration of function 'page_cache_release' [-Werror=implicit-function-declaration]
drivers/misc/vmw_vmci/vmci_queue_pair.c: In function 'qp_guest_endpoint_create':
drivers/misc/vmw_vmci/vmci_queue_pair.c:975:8: warning: assignment makes pointer from integer without a cast [enabled by default]
drivers/misc/vmw_vmci/vmci_queue_pair.c: In function 'qp_alloc_hypercall':
drivers/misc/vmw_vmci/vmci_queue_pair.c:1033:12: warning: assignment makes pointer from integer without a cast [enabled by default]
drivers/misc/vmw_vmci/vmci_queue_pair.c: In function 'qp_broker_create':
drivers/misc/vmw_vmci/vmci_queue_pair.c:1396:8: warning: assignment makes pointer from integer without a cast [enabled by default]
drivers/misc/vmw_vmci/vmci_queue_pair.c:1450:3: error: implicit declaration of function 'kcalloc' [-Werror=implicit-function-declaration]
drivers/misc/vmw_vmci/vmci_queue_pair.c:1450:20: warning: assignment makes pointer from integer without a cast [enabled by default]
drivers/misc/vmw_vmci/vmci_queue_pair.c: In function 'vmci_qpair_alloc':
drivers/misc/vmw_vmci/vmci_queue_pair.c:2866:11: warning: assignment makes pointer from integer without a cast [enabled by default]
cc1: some warnings being treated as errors
make[2]: *** [drivers/misc/vmw_vmci/vmci_queue_pair.o] Error 1


Should all of vmci depend on BLOCK?

Add this line to its Kconfig file?
	depends on PCI && BLOCK

?

-- 
~Randy
