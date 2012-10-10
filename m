From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Wed, 10 Oct 2012 13:37:16 +0200
Message-ID: <20121010113716.GA5737@redhat.com>
References: <87bogddq0l.fsf@codemonkey.ws> <5072EA14.30809@redhat.com>
	<87k3v1gfw1.fsf@codemonkey.ws> <507333F1.1060000@redhat.com>
	<874nm4u1in.fsf@codemonkey.ws> <87sj9o8qn7.fsf@rustcorp.com.au>
	<87sj9oh0pm.fsf@codemonkey.ws> <87haq48hds.fsf@rustcorp.com.au>
	<874nm3ycj8.fsf@codemonkey.ws> <87wqyz6lf8.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wqyz6lf8.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 10, 2012 at 02:14:11PM +1030, Rusty Russell wrote:
> > See above.  A guest could happily just use BAR1/BAR2 and completely
> > ignore BAR0 provided that BAR1/BAR2 are present.
> 
> But x86 guests want BAR0 because IO space is faster than MMIO.  Right?

Or to be a bit more precise, ATM on x86 emulating IO instructions is
faster than MMIO. IIUC this is since you get the address/data in
registers and don't need to decode them.

-- 
MST
