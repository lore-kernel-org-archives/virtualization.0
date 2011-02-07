From: Avi Kivity <avi@redhat.com>
Subject: Re: [SeaBIOS] IO APIC emulation failure with qemu-kvm
Date: Mon, 07 Feb 2011 11:54:03 +0200
Message-ID: <4D4FC13B.7010001__18492.071182891$1297072605$gmane$org@redhat.com>
References: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>	<4D4C0613.9050309@siemens.com>	<4D4ED860.2060109@redhat.com>	<AANLkTimMQ5hcbtBaYae8p1YBv60GbCYitYRiCZ=P-tKv@mail.gmail.com>	<4D4FB231.1050107@redhat.com>	<AANLkTik_vm3anS7V6uPr-+9Duz2SUDvoJT=MPsuA-Rv2@mail.gmail.com>	<4D4FBB83.4030103@redhat.com>
	<AANLkTi=p1R63Oaw9BkZ_YLVB54Yi7mQkFt5L6W5Um1ph@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=p1R63Oaw9BkZ_YLVB54Yi7mQkFt5L6W5Um1ph@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ravi Kumar Kulkarni <ravilinux4u@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, seabios@seabios.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/07/2011 11:47 AM, Ravi Kumar Kulkarni wrote:
> >
> >  That is not the same address.  And the code you posted doesn't make any
> >  sense.
> >
>   sorry for the mistake. here's the correct one
>
>
> (qemu) xp /20iw 0x1e2f3f7b
>                        0x000000001e2f3f7b:  (bad)
>                        0x000000001e2f3f7c:  std
>                        0x000000001e2f3f7d:  (bad)
>                        0x000000001e2f3f7e:  (bad)

That looks like garbage.  Are you sure you're disassembling the right code?

-- 
error compiling committee.c: too many arguments to function
