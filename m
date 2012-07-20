From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: 0xB16B00B5? Really? (was Re: Move hyperv out of the drivers/staging/ directory)
Date: Fri, 20 Jul 2012 09:59:01 +0200
Message-ID: <87fw8mlv7e.fsf@nemi.mork.no>
References: <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
	<20111004170415.GA1320@suse.de>
	<6E21E5352C11B742B20C142EB499E048081EB86F@TK5EX14MBXC124.redmond.corp.microsoft.com>
	<20111004193414.GA15672@suse.de> <4FFFF711.8040003@redhat.com>
	<426367E2313C2449837CD2DE46E7EAF923547292@SN2PRD0310MB382.namprd03.prod.outlook.com>
	<20120719210709.GA32031@kroah.com>
	<426367E2313C2449837CD2DE46E7EAF9235475EE@SN2PRD0310MB382.namprd03.prod.outlook.com>
	<20120719220142.GA1513@kroah.com>
	<426367E2313C2449837CD2DE46E7EAF923547620@SN2PRD0310MB382.namprd03.prod.outlook.com>
	<20120719232832.GA6317@kroah.com>
	<426367E2313C2449837CD2DE46E7EAF9235476BC@SN2PRD0310MB382.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <426367E2313C2449837CD2DE46E7EAF9235476BC@SN2PRD0310MB382.namprd03.prod.outlook.com>
	(KY Srinivasan's message of "Fri, 20 Jul 2012 00:41:37 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>, Paolo Bonzini <pbonzini@redhat.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

KY Srinivasan <kys@microsoft.com> writes:

> Here is the link that describes how the guest ID should be composed:
>
> http://msdn.microsoft.com/en-us/library/windows/hardware/ff542653%28v=
=3Dvs.85%29.aspx

The unwanted value does not conform to those rules:  Linux is not yet a=
t
major version 0xB5.

I propose that you change this into a macro actually taking the OS
major/minor version into account, keeping the 0xB16B vendor ID (which
seems safest as the vendor ID registration process seems a bit unclear)=
 =20


Bj=C3=B8rn
