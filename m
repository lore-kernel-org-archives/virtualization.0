From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC qemu 0/4] A PV solution for live migration optimization
Date: Thu, 10 Mar 2016 13:27:28 +0530
Message-ID: <20160310075728.GB4678__44883.3643379205$1457596696$gmane$org@grmbl.mre>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<20160308111343.GM15443@grmbl.mre>
	<F2CBF3009FA73547804AE4C663CAB28E0414A7E3@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E0414A7E3@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 10 Mar 2016 [07:44:19], Li, Liang Z wrote:
> 
> Hi Amit,
> 
>  Could provide more information on how to use virtio-serial to exchange data?  Thread , Wiki or code are all OK. 
>  I have not find some useful information yet.

See this commit in the Linux sources:

108fc82596e3b66b819df9d28c1ebbc9ab5de14c

that adds a way to send guest trace data over to the host.  I think
that's the most relevant to your use-case.  However, you'll have to
add an in-kernel user of virtio-serial (like the virtio-console code
-- the code that deals with tty and hvc currently).  There's no other
non-tty user right now, and this is the right kind of use-case to add
one for!

For many other (userspace) use-cases, see the qemu-guest-agent in the
qemu sources.

The API is documented in the wiki:

http://www.linux-kvm.org/page/Virtio-serial_API

and the feature pages have some information that may help as well:

https://fedoraproject.org/wiki/Features/VirtioSerial

There are some links in here too:

http://log.amitshah.net/2010/09/communication-between-guests-and-hosts/

Hope this helps.


		Amit
