From: Paul Bolle <pebolle@tiscali.nl>
Subject: RE: 2976579765? Really? (was Re: Move hyperv out of the
 drivers/staging/ directory)
Date: Fri, 13 Jul 2012 22:30:57 +0200
Message-ID: <1342211457.15453.4.camel@x61.thuisdomein>
References: <1316708240-25048-1-git-send-email-kys@microsoft.com>
	 <20110922170450.GA4490@suse.de>
	 <6E21E5352C11B742B20C142EB499E048081E935D@TK5EX14MBXC124.redmond.corp.microsoft.com>
	 <20110922173618.GA5624@suse.de>
	 <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
	 <20111004170415.GA1320@suse.de>
	 <6E21E5352C11B742B20C142EB499E048081EB86F@TK5EX14MBXC124.redmond.corp.microsoft.com>
	 <20111004193414.GA15672@suse.de> <4FFFF711.8040003@redhat.com>
	 <426367E2313C2449837CD2DE46E7EAF9223B57EC@SN2PRD0310MB382.namprd03.prod.outlook.com>
	 <50001F71.9070806@redhat.com>
	 <426367E2313C2449837CD2DE46E7EAF9223B580C@SN2PRD0310MB382.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <426367E2313C2449837CD2DE46E7EAF9223B580C@SN2PRD0310MB382.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Greg KH <gregkh@suse.de>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2012-07-13 at 13:21 +0000, KY Srinivasan wrote:
> Ok! I don't know how easy it is to change this.

I'd say nothing could possibly break if you just changed that line to
    #define HV_LINUX_GUEST_ID_HI           2976579765

(Not that I, somehow, tested this.)


Paul Bolle
