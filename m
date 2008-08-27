From: Avi Kivity <avi@qumranet.com>
Subject: Re: Virtio File System.
Date: Wed, 27 Aug 2008 13:59:37 +0300
Message-ID: <48B53399.1030809__19806.6814257347$1219834921$gmane$org@qumranet.com>
References: <S1752885AbYH0IaB/20080827083001Z+28@vger.kernel.org>
	<20080827104423.GA2670@scottrix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080827104423.GA2670@scottrix.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: scott.kvm@scottrix.co.uk
Cc: kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

scott.kvm@scottrix.co.uk wrote:
>
> I am new to this mailing list, so please let me know if I am in the 
> wrong place or asking questions in a way I shouldn't.
>

Here is fine.  virtualization@lists.linux-foundation.org is also a good 
place since virtio is not kvm specific.

> I was wondering if anyone had thought about creating a virtio file 
> system, rather than using a block device and hence a single file on 
> the host OS as the virtio block device already does, but map file 
> system calls on the guest OS to file system calls on the host OS 
> through the virtio interface.  In this way the Guest OS could share 
> files with the Host OS without needing to use Samba, which from my 
> current experiences is rather slow.

There was some work using the plan 9 filesystem protocol over virtio.  
Not sure where that stands.  You could base your work off that.

>
> I have started to play with the idea a little myself, but my biggest 
> problem is that I have no clue how to write filesystem drives in my 
> Guest OS, Window XP, or even if it is possible to get a Windows 
> FileSystem driver to talk directly to a PCI device, or if some kind of 
> dummy block device would be needed.
>

It ought to be possible; the Windows smb stack works without a block device.

> My host OS is Linux, Guest OS is Windows XP.  Maybe I should start 
> with a Linux/Linux setup and get that working first ?

That's definitely a good idea.

-- 
error compiling committee.c: too many arguments to function
