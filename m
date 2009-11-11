From: Adam Litke <agl@us.ibm.com>
Subject: Re: [Qemu-devel] Re: virtio: Add memory statistics reporting to
	the balloon driver
Date: Wed, 11 Nov 2009 07:26:24 -0600
Message-ID: <1257945984.2876.1.camel__28509.6069019803$1257946140$gmane$org@aglitke>
References: <1257782838.2835.5.camel@aglitke>
	<1257784326.2835.16.camel@aglitke>
	<200911101312.02650.rusty@rustcorp.com.au>
	<4AF97A5E.1070801@codemonkey.ws>
	<4AF97C1A.2080609@redhat.com> <4AF97F93.2080707@us.ibm.com>
	<20091111092409.GA24646@shareable.org>
	<20091111101223.GA22937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091111101223.GA22937@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, agl@linux.vnet.ibm.com, qemu-devel@nongnu.org, Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2009-11-11 at 10:12 +0000, Daniel P. Berrange wrote:
> This all suggests that we should only update the stats from the guest
> when something on the host actually asks for them by issuing the QEMU
> monitor command. We don't want any kind of continuous polling of stats
> at any frequency, if nothing is using these stats on the host.

Agreed.  The next version of the patch will remove the timer completely.
We'll wake up in response to config change notifications only.

-- 
Thanks,
Adam
