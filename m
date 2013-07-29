From: Matt Wilson <msw@amazon.com>
Subject: Re: [PATCH] kexec/kdump implementation for Xen PV domU
Date: Mon, 29 Jul 2013 14:44:19 -0700
Message-ID: <20130729214419.GA4239@u109add4315675089e695.ant.amazon.com>
References: <20130729171543.GA2600@router-fw-old.local.net-space.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130729171543.GA2600@router-fw-old.local.net-space.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <dkiper@net-space.pl>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, gregkh@linuxfoundation.org, daniel.kiper@oracle.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, abyde@acunu.com, tim@acunu.com, ebiederm@xmission.com, brandon@ifup.org, grzegorz.milos@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 29, 2013 at 07:15:43PM +0200, Daniel Kiper wrote:
> Hi all,
> 
> Here I am sending as attachments patches enabling kexec/kdump
> support in Xen PV domU. Only x84_64 architecture is supported.
> There is no support for i386 but some code could be easily reused.
> Here is a description of patches:

[...]

>   - kexec-kernel-only_20121203.patch: this patch fixes timer
>     issue on Amazon EC2 machines.

Hi Daniel,

Do you know the cause of this issue? Does it have something to do with
singleshot timer migration when offlining/onlining SMP CPUs?

--msw
