From: yhlu <yhlu.kernel@gmail.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Tue, 8 May 2007 19:44:04 -0700
Message-ID: <86802c440705081944v27e5311fp14974813dbd5adf2__6115.51632541722$1178729083$gmane$org@mail.gmail.com>
References: <4634483E.9030307@goop.org>
	<86802c440705081033s19365843i5b955ae175de73eb@mail.gmail.com>
	<86802c440705081151r6bfd82e4o50c6a34b2b2a833f@mail.gmail.com>
	<m1k5vji107.fsf@ebiederm.dsl.xmission.com>
	<86802c440705081500x682ee098y7d51f7bb98dbcff6@mail.gmail.com>
	<4640F4B3.30408@goop.org> <4640FB2C.2060300@zytor.com>
	<86802c440705081541v7d0773cek2c5fae1854b68bbc@mail.gmail.com>
	<46410403.4050802@zytor.com>
	<m17irivkhy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m17irivkhy.fsf@ebiederm.dsl.xmission.com>
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
> "H. Peter Anvin" <hpa@zytor.com> writes:
> I believe YH is asking how we setup real_mode_data in /sbin/kexec.

pxelinux:

SCREEN_INFO.orig_video_mode =  3
SCREEN_INFO.orig_x =  0
SCREEN_INFO.orig_y =  24
x86_boot_params[] :
0000: 00 18 ff ff 08 00 03 50 8c c8 03 00 8e c0 19 01
0010: 10 00 7c fb fc be 31 00 ac 20 c0 74 09 b4 0e bb
0020: 07 00 cd 10 eb f2 31 c0 cd 16 cd 19 ea f0 ff 00
0030: f0 44 69 72 65 63 74 20 62 6f 6f 74 15 00 10 00

current kexec:
SCREEN_INFO.orig_video_mode =  0
SCREEN_INFO.orig_x =  0
SCREEN_INFO.orig_y =  3
x86_boot_params[] :
0000: 00 03 00 fc 00 00 00 50 8c c8 00 00 8e c0 19 01
0010: 10 00 7c fb fc be 31 00 ac 20 c0 74 09 b4 0e bb
0020: 3f a3 00 16 eb f2 31 c0 cd 16 cd 19 ea f0 ff 00
0030: f0 44 69 72 65 63 74 20 62 6f 6f 74 15 00 20 00

YH
