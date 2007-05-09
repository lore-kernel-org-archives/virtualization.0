From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol
 for relocatable bzImage
Date: Tue, 08 May 2007 22:08:12 -0700
Message-ID: <4641573C.1000205__25790.2549965822$1178741807$gmane$org@zytor.com>
References: <4634483E.9030307@goop.org>
	<m1k5vji107.fsf@ebiederm.dsl.xmission.com>
	<86802c440705081500x682ee098y7d51f7bb98dbcff6@mail.gmail.com>
	<4640F4B3.30408@goop.org> <4640FB2C.2060300@zytor.com>
	<86802c440705081541v7d0773cek2c5fae1854b68bbc@mail.gmail.com>
	<46410403.4050802@zytor.com> <m17irivkhy.fsf@ebiederm.dsl.xmission.com>
	<46413087.2020505@zytor.com> <m1tzumu10k.fsf@ebiederm.dsl.xmission.com>
	<86802c440705082152g49d4d3echf3eb165ce4feb2e9@mail.gmail.com>
	<46415640.6000600@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46415640.6000600@zytor.com>
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
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> yhlu wrote:
>> On 5/8/07, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>> Since the whole point is to detect the case where we don't have
>>> a screen at all it makes sense to check several additional variables
>>> and make certain that they are all 0.  Agreed?
>> need one good way to find if there is support vga console.
> 
> There really isn't one, at least not given the current data structure;
> the data structure has an "isVGA" flag, but if that is 0 it's supposed
> to mean CGA/MDA/HGC/EGA, as opposed to VGA...

Of course, one could argue that since all of those were obsolete by the
time Linux was first created, that it probably doesn't matter and that
isVGA == 0 pretty much means the more obvious thing.

MDA/HGC stuck around for quite a while for debugging, since it was
non-conflicting with VGA, but even if it is, the reason people put it in
their system is to have something that the OS doesn't readily see.

	-hpa
