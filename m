From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] Use PCI revision field to indicate virtio PCI ABI
	version
Date: Tue, 29 Jan 2008 16:39:59 +0100
Message-ID: <200801291639.59184.borntraeger@de.ibm.com>
References: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
	<479F3E8D.8000308@us.ibm.com> <479F4704.8080107@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479F4704.8080107@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 29. Januar 2008 schrieb Avi Kivity:
> Yeah, okay.  We'll bump it one last time when 2.6.25 is released.
> 
> I'll merge the userspace side.

Do we really want to freeze the interface for virtio already with 2.6.25? 
Maybe every possible issue is found then, but I would prefer to have a more
flexible schedule on finalizing virtio. Dont know if I am just paranoid...

Christian
