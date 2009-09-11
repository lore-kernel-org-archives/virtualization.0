From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Fri, 11 Sep 2009 17:00:10 +0100
Message-ID: <20090911170010.34c80f2d__48371.3704547428$1252685387$gmane$org@linux.intel.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1252678386-17404-2-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> The interface presented to guest userspace is of a simple char
> device, so it can be used like this:
> 
>     fd = open("/dev/vcon2", O_RDWR);
>     ret = read(fd, buf, 100);
>     ret = write(fd, string, strlen(string));
> 
> Each port is to be assigned a unique function, for example, the
> first 4 ports may be reserved for libvirt usage, the next 4 for
> generic streaming data and so on. This port-function mapping
> isn't finalised yet.

Unless I am missing something this looks completely bonkers

Every time we have a table of numbers for functionality it ends in
tears. We have to keep tables up to date and managed, we have to
administer the magical number to name space.

Anyway - you don't seem to need a fixed number you can use dynamic
allocation and udev.

There are at least two better ways to do this

- Using sysfs nodes so you have a proper heirarchy of names/functions
- Using a simple file system which provides a heirarchy of nodes whose
  enumeration and access is backed by calls to whatever happyvisor you
  are using.

it then self enumerates, self populates, doesn't need anyone to keep
updating magic tables of guest code and expands cleanly - yes ?

Alan
