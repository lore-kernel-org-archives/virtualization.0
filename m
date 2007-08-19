From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH/RFC 4/4,
	second shot]KVM uses "account_guest_time()"
Date: Sun, 19 Aug 2007 10:39:49 +0300
Message-ID: <46C7F3C5.1000805__43042.5659673803$1187509364$gmane$org@qumranet.com>
References: <46C4719A.2060308@bull.net>	<46C4720F.7030304@bull.net>		<46C4725A.4070607@bull.net>	<46C4740F.2050701@bull.net>		<1187303955.6449.7.camel@localhost.localdomain>	<46C54FB8.7050504@bull.net>	<1187339450.6449.115.camel@localhost.localdomain>	<46C56774.2030009@bull.net>	<46C58BD5.3090207@bull.net>
	<46C58C8C.3080803@bull.net> <46C59C92.40902@qumranet.com>
	<46C59FA6.7020601@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C59FA6.7020601@bull.net>
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
>> Other way round.  In the patch that adds account_guest_time(), have a
>> CONFIG_GUEST_ACCOUNTING (defaulting to n, with no description, help, or
>> dependencies.  Then, CONFIG_KVM can select GUEST_ACCOUNTING.
>>     
>
> I was wondering in which Kconfig I can put it...
>
>   

Looks like init/Kconfig has similar stuff.

-- 
error compiling committee.c: too many arguments to function
