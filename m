From: yhlu <yhlu.kernel@gmail.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Tue, 8 May 2007 10:34:42 -0700
Message-ID: <86802c440705081034p63b598faqdf1205fdae02f86f__2708.19822694666$1178645749$gmane$org@mail.gmail.com>
References: <46385A8A.6070405@redhat.com> <4638F9BE.8090508@zytor.com>
	<4638FC39.4010101@goop.org> <4638FE1B.9050901@zytor.com>
	<46390523.5010809@goop.org> <463909AF.9040205@zytor.com>
	<20070503045031.GA5794@in.ibm.com>
	<m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>
	<86802c440705080941y69ddd5d6lab170c5f3967f148@mail.gmail.com>
	<20070508172449.GA1932@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070508172449.GA1932@in.ibm.com>
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
To: vgoyal@in.ibm.com
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On 5/8/07, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> setup.S is never executed while doing kexec (unless somebody chooses to
> do a real mode entry) and these patches don't change this beahviour.
>
> Tomorrow I will test VGA behaviour on my machine. Are you using some
> special frame buffer mode etc?
>

I disabled the FB in the kernel.

YH
