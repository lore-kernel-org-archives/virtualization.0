From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Feb 13 (virtio_console)
Date: Thu, 14 Feb 2013 10:55:06 -0800
Message-ID: <511D330A.2050407__49552.1677229137$1360868092$gmane$org@infradead.org>
References: <20130213193532.162080d7c0557a307ab451ac@canb.auug.org.au>
	<511BEC55.5090801@infradead.org> <87sj4zk3ai.fsf@rustcorp.com.au>
	<511D30B4.5020201@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <511D30B4.5020201@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/14/13 10:45, Randy Dunlap wrote:
> On 02/13/13 19:00, Rusty Russell wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>
>>> On 02/13/13 00:35, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20130212:
>>>
>>> on i386:
>>>
>>> drivers/built-in.o: In function `in_intr':
>>> virtio_console.c:(.text+0x2dd31): undefined reference to `hvc_poll'
>>> virtio_console.c:(.text+0x2dd41): undefined reference to `hvc_kick'
>>> drivers/built-in.o: In function `resize_console':
>>> virtio_console.c:(.text+0x2e26f): undefined reference to `__hvc_resize'
>>> drivers/built-in.o: In function `unplug_port':
>>> virtio_console.c:(.text+0x2e572): undefined reference to `hvc_remove'
>>> drivers/built-in.o: In function `init_port_console':
>>> (.text+0x2fe59): undefined reference to `hvc_alloc'
>>> drivers/built-in.o: In function `virtio_cons_early_init':
>>> (.init.text+0x16d1): undefined reference to `hvc_instantiate'
>>>
>>>
>>> Full randconfig file is attached.
>>
>> This looks like an impossible config.  CONFIG_VIRTIO_CONSOLE=y, but
>> CONFIG_HVC_DRIVER isn't set.
>>
>> From drivers/char/Kconfig:
>>
>>         config VIRTIO_CONSOLE
>>         	tristate "Virtio console"
>>         	depends on VIRTIO
>>         	select HVC_DRIVER
>>
>> ???
> 
> OK.  It's probably yet another stinking problem with kvmtool and randconfig.
> Running *config reports:
> 
> warning: (KVMTOOL_TEST_ENABLE && LGUEST_GUEST) selects VIRTIO_CONSOLE which has unmet direct dependencies (VIRTIO && TTY)
> 
> 
> I'll look a bit more...

Nope, that's not it.  Stephen's comments were much closer.

The patch below fixes the kconfig warning and the build errors.
---



From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warning for LGUEST_GUEST config by selecting TTY:

warning: (KVMTOOL_TEST_ENABLE && LGUEST_GUEST) selects VIRTIO_CONSOLE which has unmet direct dependencies (VIRTIO && TTY)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 arch/x86/lguest/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20130213.orig/arch/x86/lguest/Kconfig
+++ linux-next-20130213/arch/x86/lguest/Kconfig
@@ -2,6 +2,7 @@ config LGUEST_GUEST
 	bool "Lguest guest support"
 	select PARAVIRT
 	depends on X86_32
+	select TTY
 	select VIRTUALIZATION
 	select VIRTIO
 	select VIRTIO_CONSOLE
