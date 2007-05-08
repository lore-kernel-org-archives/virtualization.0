From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Tue, 08 May 2007 15:07:47 -0700
Message-ID: <4640F4B3.30408__21378.1003411443$1178662183$gmane$org@goop.org>
References: <4634483E.9030307@goop.org> <46390523.5010809@goop.org>	
	<463909AF.9040205@zytor.com> <20070503045031.GA5794@in.ibm.com>	
	<m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>	
	<86802c440705080941y69ddd5d6lab170c5f3967f148@mail.gmail.com>	
	<m1sla7i68s.fsf@ebiederm.dsl.xmission.com>	
	<86802c440705081033s19365843i5b955ae175de73eb@mail.gmail.com>	
	<86802c440705081151r6bfd82e4o50c6a34b2b2a833f@mail.gmail.com>	
	<m1k5vji107.fsf@ebiederm.dsl.xmission.com>
	<86802c440705081500x682ee098y7d51f7bb98dbcff6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <86802c440705081500x682ee098y7d51f7bb98dbcff6@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: yhlu <yhlu.kernel@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, vgoyal@in.ibm.com, "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

yhlu wrote:
> On 5/8/07, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> You might try a git-bisect, or if it is just these patches
>> walking through them one-by-one.
>
> f82af20e1a028e16b9bb11da081fa1148d40fa6a is first bad commit
> commit f82af20e1a028e16b9bb11da081fa1148d40fa6a
> Author: Gerd Hoffmann <kraxel@suse.de>
> Date:   Wed May 2 19:27:19 2007 +0200
>
>    [PATCH] x86-64: ignore vgacon if hardware not present
>
>    Avoid trying to set up vgacon if there's no vga hardware present.
>
>    Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>    Signed-off-by: Andi Kleen <ak@suse.de>
>    Cc: Alan <alan@lxorguk.ukuu.org.uk>
>    Acked-by: Ingo Molnar <mingo@elte.hu>

Interesting.  I haven't really been following this thread, but doesn't
it mean something isn't being initialized properly if this patch makes a
difference?

    J
