From: Borislav Petkov <bp@alien8.de>
Subject: Re: 0xB16B00B5? Really? (was Re: Move hyperv out of the
 drivers/staging/ directory)
Date: Thu, 19 Jul 2012 17:30:15 +0200
Message-ID: <20120719153014.GA13235@x1.osrc.amd.com>
References: <1316708240-25048-1-git-send-email-kys@microsoft.com>
 <20110922170450.GA4490@suse.de>
 <6E21E5352C11B742B20C142EB499E048081E935D@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110922173618.GA5624@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004170415.GA1320@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB86F@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004193414.GA15672@suse.de>
 <4FFFF711.8040003@redhat.com>
 <426367E2313C2449837CD2DE46E7EAF923547292@SN2PRD0310MB382.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <426367E2313C2449837CD2DE46E7EAF923547292@SN2PRD0310MB382.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 19, 2012 at 02:11:47AM +0000, KY Srinivasan wrote:
> As I noted earlier, this is just a guest ID that needs to be
> registered with the hypervisor. Thanks for reporting this issue and
> on behalf of Microsoft, I would like to apologize for this offensive
> string. I have submitted a patch to fix this issue.

Ok, quick question:

http://msdn.microsoft.com/en-us/library/windows/hardware/ff542653%28v=vs.85%29.aspx

says that that guest ID encodes a bunch of version numbers and IDs
pertaining to the guest OS. And in that case, I would've thought
you'd encode kernel versions or whatever like it is done with
LINUX_VERSION_CODE, for example.

How does this define fit with that scheme or was it chosen completely
arbitrarily?

Thanks.

-- 
Regards/Gruss,
Boris.
