From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH/RFC 3/4]Introduce "account modifiers"
	mechanism
Date: Mon, 20 Aug 2007 10:55:52 +0300
Message-ID: <46C94908.5080008__17650.3863338896$1187596729$gmane$org@qumranet.com>
References: <46C4719A.2060308@bull.net>
	<46C4720F.7030304@bull.net>		<46C4725A.4070607@bull.net>
	<46C4740F.2050701@bull.net>		<1187303955.6449.7.camel@localhost.localdomain>	<46C54FB8.7050504@bull.net>	<1187339450.6449.115.camel@localhost.localdomain>
	<46C56774.2030009@bull.net> <46C59AB1.6070505@qumranet.com>
	<46C5ACE8.2050004@bull.net> <46C7F362.80106@qumranet.com>
	<46C94306.8080300@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C94306.8080300@bull.net>
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
>>
>> Where did CONFIG_GUEST_ACCOUNTING go?
>>
>>     
>
> Lost in the sea ...
>
> Actually, I thought this modification is not enough expensive (in time and
> space) to justify a CONFIG_*. But if you think so I can add this in init/Kconfig.
>
>   

The difference between "convince everyone that it isn't expensive, 
including the embedded guys" and preemptively adding a config option can 
be quite large...

-- 
error compiling committee.c: too many arguments to function
