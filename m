From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Thu, 09 Aug 2007 00:12:50 -0700
Message-ID: <46BABE72.90107__38223.6262587414$1186643841$gmane$org@goop.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>	
	<11865468321629-git-send-email-gcosta@redhat.com>	
	<11865468362401-git-send-email-gcosta@redhat.com>	
	<11865468394005-git-send-email-gcosta@redhat.com>	
	<11865468431616-git-send-email-gcosta@redhat.com>	
	<1186546847263-git-send-email-gcosta@redhat.com>	
	<11865468513077-git-send-email-gcosta@redhat.com>	
	<46BAB5C8.5090906@goop.org>	
	<5d6222a80708090002y7fdc6f2dw1dbacd3d27a86433@mail.gmail.com>	
	<46BABC0F.5070002@goop.org>
	<5d6222a80708090007h3d185ecdm3ea8fa0b5ee96050@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708090007h3d185ecdm3ea8fa0b5ee96050@mail.gmail.com>
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
> On 8/9/07, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>   
>>> Does it really matter?
>>>
>>>       
>> Well, yes, if alignment is an issue.
>>     
> Of course, But the question rises from the context that they are both
> together at the beginning. So they are not making anybody non-aligned.
> Then the question: Why would putting it in the end be different to
> putting them _together_, aligned at the beginning ?
>   

Well, the point is that if you add new ones then alignment may be an
issue.  Putting them at the end (with a comment explaining why they're
there) will make it more robust.  Though splitting them into their own
sub-structure would probably be better.

Hm.  So x86-64 doesn't make 64-bit pointers be 64-bit aligned?

    J
