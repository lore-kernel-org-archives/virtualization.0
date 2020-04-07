From: Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH] Fix: buffer overflow during hvc_alloc().
Date: Tue, 7 Apr 2020 16:23:06 +1000
Message-ID: <06ecf4d9-80d7-fbfd-3f95-9241d8d0d5cd@linux.ibm.com>
References: <20200405204024.1007843-1-andrew@daynix.com>
 <a8ab8fe3-3200-9591-7572-abbbd2d505ff@linux.ibm.com>
 <CABcq3pHMSN9vZRrV1xL6nA7HOK-+wnFSEQsqTqFVvKr4usNbOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABcq3pHMSN9vZRrV1xL6nA7HOK-+wnFSEQsqTqFVvKr4usNbOg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Melnichenko <andrew@daynix.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 6/4/20 6:05 pm, Andrew Melnichenko wrote:
> 
>     Steps to Reproduce:
> 
>     1. boot guest with command [1]
>     2. load and unload virtio_console inside guest with loop.sh
>         # cat loop.sh
>          while [ 1 ]
>          do
>     modprobe virtio_console
>     lsmod | grep virt
>     modprobe -r virtio_console
>     lsmod | grep virt
>          done
> 
> 
> 
>     Actual results:
>     Guest reboot and can get vmcore-dmesg.txt file
> 
> 
>     Expected results:
>     Guest works well without error
> 
> 
>     Additional info:
>     The whole log will attach to the attachments.
> 
>     Call Trace:
>     [   22.974500] fuse: init (API version 7.31)
>     [   81.498208] ------------[ cut here ]------------
>     [   81.499263] pvqspinlock: lock 0xffffffff92080020 has corrupted
>     value 0xc0774ca0!
>     [   81.501000] WARNING: CPU: 0 PID: 785 at
>     kernel/locking/qspinlock_paravirt.h:500

[snip]

Thanks!

You should include an appropriate excerpt from this - the WARNING 
message and stack trace, and the steps to reproduce - in the commit 
message of the patch.


-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
