From: Avi Kivity <avi@redhat.com>
Subject: Re: Help - KVM TODO_NOV2008_Sharing Memory between guests
Date: Wed, 25 Feb 2009 15:38:57 +0200
Message-ID: <49A549F1.8000901@redhat.com>
References: <b20fe0330902210535p1efb68bcv282853c5f4f08f3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b20fe0330902210535p1efb68bcv282853c5f4f08f3b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: PICT PUNE <kvm.smartshare@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

PICT PUNE wrote:
> In reference to the November 2008 todo list on Qumranet Website
>
> we are a group of college students working on this todo:
>
> *Add a qemu interface for sharing memory between guests. Using a pci 
> device to expose the shared memory is probably a good starting point.
> *
> Can anyone suggest us some starting point or a possible approach for 
> the same...

Write a PCI device that exposes a BAR containing RAM.  Implement the RAM 
by mapping a shared memory segment or a file.  Write a guest driver to 
use this shared RAM.

-- 
error compiling committee.c: too many arguments to function
