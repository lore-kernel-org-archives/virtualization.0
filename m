From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Tue, 08 May 2007 15:35:24 -0700
Message-ID: <4640FB2C.2060300__25274.1063865416$1178663856$gmane$org@zytor.com>
References: <4634483E.9030307@goop.org> <46390523.5010809@goop.org>	
	<463909AF.9040205@zytor.com> <20070503045031.GA5794@in.ibm.com>	
	<m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>	
	<86802c440705080941y69ddd5d6lab170c5f3967f148@mail.gmail.com>	
	<m1sla7i68s.fsf@ebiederm.dsl.xmission.com>	
	<86802c440705081033s19365843i5b955ae175de73eb@mail.gmail.com>	
	<86802c440705081151r6bfd82e4o50c6a34b2b2a833f@mail.gmail.com>	
	<m1k5vji107.fsf@ebiederm.dsl.xmission.com>
	<86802c440705081500x682ee098y7d51f7bb98dbcff6@mail.gmail.com>
	<4640F4B3.30408@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4640F4B3.30408@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, vgoyal@in.ibm.com, yhlu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> 
> Interesting.  I haven't really been following this thread, but doesn't
> it mean something isn't being initialized properly if this patch makes a
> difference?
> 

Specifically boot_params.screen_info isn't being properly set up by the
caller.

	-hpa
