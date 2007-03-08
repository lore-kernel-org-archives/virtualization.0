From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: system call time increase when turning on CONFIG_PARAVIRT
Date: Wed, 07 Mar 2007 16:02:04 -0800
Message-ID: <1173312124.8383.35.camel@localhost.localdomain>
References: <1172866274.4898.14.camel@localhost.localdomain>
	<45E89CFB.4090905@goop.org>
	<1172877111.8383.4.camel@localhost.localdomain>
	<45E8BE79.40200@goop.org>
Reply-To: tim.c.chen@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45E8BE79.40200@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, zach@vmware.com
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-03-02 at 16:16 -0800, Jeremy Fitzhardinge wrote:

> =

> Yes, the intent is that running a CONFIG_PARAVIRT kernel on native
> hardware will have negligible performance hit compared to running a
> non-paravirt kernel.
> =

>     J

It turned out that VDSO was turned off by CONFIG_PARAVIRT option,
causing the system call to use inefficient int 0x80 which led to the
increase system_call time I was seeing.  I noted that Ingo has caught
this problem and proposed a patch to correct this issue in another mail
thread.

Tim
