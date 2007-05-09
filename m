From: "yhlu" <yhlu.kernel@gmail.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol
 for relocatable bzImage
Date: Tue, 8 May 2007 21:52:14 -0700
Message-ID: <86802c440705082152g49d4d3echf3eb165ce4feb2e9__37675.252770032$1178741103$gmane$org@mail.gmail.com>
References: <4634483E.9030307@goop.org>
	<m1k5vji107.fsf@ebiederm.dsl.xmission.com>
	<86802c440705081500x682ee098y7d51f7bb98dbcff6@mail.gmail.com>
	<4640F4B3.30408@goop.org> <4640FB2C.2060300@zytor.com>
	<86802c440705081541v7d0773cek2c5fae1854b68bbc@mail.gmail.com>
	<46410403.4050802@zytor.com> <m17irivkhy.fsf@ebiederm.dsl.xmission.com>
	<46413087.2020505@zytor.com> <m1tzumu10k.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1tzumu10k.fsf@ebiederm.dsl.xmission.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, vgoyal@in.ibm.com, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 5/8/07, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Since the whole point is to detect the case where we don't have
> a screen at all it makes sense to check several additional variables
> and make certain that they are all 0.  Agreed?

need one good way to find if there is support vga console.

YH
