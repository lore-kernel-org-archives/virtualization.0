From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: more build errors ...
Date: Tue, 09 Jan 2007 10:55:17 -0800
Message-ID: <45A3E515.8010004@goop.org>
References: <45A37BC4.6060303@suse.de> <45A396AE.8090109@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A396AE.8090109@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
>>   arch/i386/kernel/built-in.o: In function `APIC_init_uniprocessor':
>>   (.init.text+0x6357): undefined reference to `setup_boot_clock'
>>     =

>
>   =

>>   drivers/built-in.o: In function `xencons_rx':
>>   (.text+0x17f09): undefined reference to `sysrq_enabled'
>>     =

>
> Here is the fix for both.  Not fully sure the first one is correct
> though, I've just moved the inline functions into the correct #ifdef
> CONFIG_foo section, but didn't uninline them like rusty did for the
> apic_* ones.  As they are hardly called by modules it should be ok this
> way I think.
>   =

Thanks.  I've merged the xen-console one; I'll do the other one shortly.

    J
