From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: Re: [17/17][PATCH] kvm/ia64: How to boot up guests on kvm/ia64 -V8
Date: Mon, 31 Mar 2008 19:51:54 +0900
Message-ID: <A0C8931D3BDA53takebe_akio__32693.8819177032$1206961046$gmane$org@jp.fujitsu.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC01048261@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC01048261@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>, Avi Kivity <avi@qumranet.com>, "Luck, Tony" <tony.luck@intel.com>, "Xu, Anthony" <anthony.xu@intel.com>, Jes Sorensen <jes>
List-Id: virtualization@lists.linuxfoundation.org

Hi, Xiantao

>+3. Get Guest Firmware named as Flash.fd, and put it under right place:
>+	(1) If you have the guest firmware (binary)released by Intel
>Corp for Xen, you can use it directly.
>+	(2) If you want to build a guest firmware form source code.
>Please download the source from
>+		hg clone
>http://xenbits.xensource.com/ext/efi-vfirmware.hg
>+		Use the Guide of the source to build open Guest
>Firmware.
The Guide is not include in this README,
so we may make a link to the Guide in wiki.
Or we may add a link to binary release of GFW.

Best Regards,

Akio Takebe
