From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH/RFC 3/4]Introduce "account
	modifiers"	mechanism
Date: Sun, 19 Aug 2007 10:41:35 +0300
Message-ID: <46C7F42F.1080900__37633.6163645194$1187509513$gmane$org@qumranet.com>
References: <46C4719A.2060308@bull.net>
	<46C4720F.7030304@bull.net>		<46C4725A.4070607@bull.net>
	<46C4740F.2050701@bull.net>		<1187303955.6449.7.camel@localhost.localdomain>	<46C54FB8.7050504@bull.net>	<1187339450.6449.115.camel@localhost.localdomain>
	<46C56774.2030009@bull.net> <46C59AB1.6070505@qumranet.com>
	<46C59DC6.4020308@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C59DC6.4020308@bull.net>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Laurent Vivier wrote:
>> So I think it is okay to have the same limitation for guest time.
>>     
>
> OK, so we can go back to my first patch.
> Who can decide to introduce this into the kernel ?
>   

The sched.c parts are best merged by Ingo, and I can carry the kvm 
parts.  Alternatively, I can carry the entire patchset if Ingo acks it.

-- 
error compiling committee.c: too many arguments to function
