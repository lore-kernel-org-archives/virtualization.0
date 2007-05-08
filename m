From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Tue, 08 May 2007 16:13:07 -0700
Message-ID: <46410403.4050802__26624.9255081222$1178728657$gmane$org@zytor.com>
References: <4634483E.9030307@goop.org>	
	<m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>	
	<86802c440705080941y69ddd5d6lab170c5f3967f148@mail.gmail.com>	
	<m1sla7i68s.fsf@ebiederm.dsl.xmission.com>	
	<86802c440705081033s19365843i5b955ae175de73eb@mail.gmail.com>	
	<86802c440705081151r6bfd82e4o50c6a34b2b2a833f@mail.gmail.com>	
	<m1k5vji107.fsf@ebiederm.dsl.xmission.com>	
	<86802c440705081500x682ee098y7d51f7bb98dbcff6@mail.gmail.com>	
	<4640F4B3.30408@goop.org> <4640FB2C.2060300@zytor.com>
	<86802c440705081541v7d0773cek2c5fae1854b68bbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <86802c440705081541v7d0773cek2c5fae1854b68bbc@mail.gmail.com>
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
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

yhlu wrote:
> On 5/8/07, H. Peter Anvin <hpa@zytor.com> wrote:
>> Jeremy Fitzhardinge wrote:
>> Specifically boot_params.screen_info isn't being properly set up by the
>> caller.
> 
> will setup real_mode_data in kexec path?

-ENOPARSE

	-hpa
