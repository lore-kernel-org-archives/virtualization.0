From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 0/2][KVM] guest time accounting
Date: Mon, 13 Aug 2007 16:22:15 +0300
Message-ID: <46C05B07.1090206__7819.26954300633$1187011603$gmane$org@qumranet.com>
References: <46BC8B39.6050202@bull.net> <46C00FC1.1070306@qumranet.com>
	<46C012A8.2040908@bull.net> <46C01877.7060007@qumranet.com>
	<46C057C0.7020003@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C057C0.7020003@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Laurent Vivier wrote:

  

>> Are these options for using the kernel as a guest or host?  I'd guess
>> the former.
>>     
>
> I didn't find CONFIG_HYPERVISOR.
>   

I meant, add a new option CONFIG_HYPERVISOR.

> The good one seems to be CONFIG_VIRTUALIZATION that is used to activate CONFIG_KVM.
>   

It's just a menu.  Right now there's just one entry, but it will 
change.  And if CONFIG_VIRTUALIZATION is selected, it doesn't mean 
CONFIG_KVM is selected.

-- 
error compiling committee.c: too many arguments to function
