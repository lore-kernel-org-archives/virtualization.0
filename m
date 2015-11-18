From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 2/3] x86: irq_enable_sysexit pv op is no longer needed
Date: Wed, 18 Nov 2015 15:34:32 -0500
Message-ID: <564CE0D8.1030004@oracle.com>
References: <1447877179-2775-1-git-send-email-boris.ostrovsky@oracle.com>
	<1447877179-2775-3-git-send-email-boris.ostrovsky@oracle.com>
	<20151118201152.GA6094@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151118201152.GA6094@char.us.oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, david.vrabel@citrix.com, luto@kernel.org, hpa@zytor.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, bp@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On 11/18/2015 03:11 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, Nov 18, 2015 at 03:06:18PM -0500, Boris Ostrovsky wrote:
>> Xen PV guests have been the only ones using it and now they don't.
> Could you elaborate on the 'now they don't' please?
>
> Is Xen not doing it? Did it do it in the past?
>
> Is it because the Linux code paths will never run to this in Xen PV mode?
> Is that due to other patches? If so please mention the name
> of the other patches.. (so if somebody is thinking to put the
> other patches on the stable train they should also take these ones).

Since this is due to the first patch in the series I don't know its 
commitID. Should I just refer to patch title?

-boris
