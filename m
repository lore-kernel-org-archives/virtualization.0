From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH v4 4/6] xen: add xen_pin_vcpu() to support
	calling functions on a dedicated pcpu
Date: Tue, 5 Apr 2016 11:03:55 +0100
Message-ID: <57038D8B.9050602@citrix.com>
References: <1459833007-11618-1-git-send-email-jgross@suse.com>
	<1459833007-11618-5-git-send-email-jgross@suse.com>
	<57038927.1030205@citrix.com> <57038D0E.1040708@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <57038D0E.1040708@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jeremy@goop.org, jdelvare@suse.com, peterz@infradead.org, x86@kernel.org, pali.rohar@gmail.com, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, Douglas_Warzecha@dell.com, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On 05/04/16 11:01, Juergen Gross wrote:
> 
> No, I don't think this is a good idea. In the EINVAL or EBUSY case a
> simple Xen admin command might be enough to make the next call succeed.
> I don't want to disable pinning in this case.

Ok.

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
