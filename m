From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: virtio PCI on KVM without IO BARs
Date: Mon, 29 Apr 2013 16:03:22 -0700
Message-ID: <517EFC3A.5050809@zytor.com>
References: <20130228152433.GA13832@redhat.com> <517E883C.9010908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <517E883C.9010908@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Don Dutile <ddutile@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/29/2013 07:48 AM, Don Dutile wrote:
> 
> c) it's architecture neutral, or can be made architecture neutral.
>    e.g., inb/outb & PCI ioport support is very different btwn x86 &
> non-x86.
>    A hypercall interface would not have that dependency/difference.
>  

You are joking, right?  Hypercalls are if anything *more* architecture
and OS dependent.

	-hpa
