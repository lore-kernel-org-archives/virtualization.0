From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Thu, 09 Aug 2007 00:02:39 -0700
Message-ID: <46BABC0F.5070002__35223.7566411079$1186643217$gmane$org@goop.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>	
	<1186546820708-git-send-email-gcosta@redhat.com>	
	<11865468243612-git-send-email-gcosta@redhat.com>	
	<11865468321629-git-send-email-gcosta@redhat.com>	
	<11865468362401-git-send-email-gcosta@redhat.com>	
	<11865468394005-git-send-email-gcosta@redhat.com>	
	<11865468431616-git-send-email-gcosta@redhat.com>	
	<1186546847263-git-send-email-gcosta@redhat.com>	
	<11865468513077-git-send-email-gcosta@redhat.com>	
	<46BAB5C8.5090906@goop.org>
	<5d6222a80708090002y7fdc6f2dw1dbacd3d27a86433@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708090002y7fdc6f2dw1dbacd3d27a86433@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
>>> +/*
>>> + * integers must be use with care here. They can break the PARAVIRT_PATCH(x)
>>> + * macro, that divides the offset in the structure by 8, to get a number
>>> + * associated with the hook. Dividing by four would be a solution, but it
>>> + * would limit the future growth of the structure if needed.
>>>
>>>       
>> Why not just stick them at the end of the structure?
>>     
>
> Does it really matter?
>   

Well, yes, if alignment is an issue.


    J
