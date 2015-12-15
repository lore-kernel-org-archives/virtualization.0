From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 1/3] x86/xen: Avoid fast syscall path for Xen PV guests
Date: Tue, 15 Dec 2015 10:54:35 -0500
Message-ID: <567037BB.6080901@oracle.com>
References: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
	<1447970147-1733-2-git-send-email-boris.ostrovsky@oracle.com>
	<56703001.9010205@oracle.com> <20151215154830.GF26000@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151215154830.GF26000@pd.tnic>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@suse.de>
Cc: konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, david.vrabel@citrix.com, luto@kernel.org, hpa@zytor.com, xen-devel@lists.xenproject.org, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On 12/15/2015 10:48 AM, Borislav Petkov wrote:
> On Tue, Dec 15, 2015 at 10:21:37AM -0500, Boris Ostrovsky wrote:
>> I know this has been in the tip tree --- when do you think this will go
>> Linus tree? In the 4.4 timeframe?
> It is queued for 4.5 currently.
>
>> Xen 32-bit PV guests are broken without this.
> So this needs to go into 4.4 or even earlier? Since 5f310f739b4c went
> into 4.4, I'd think 4.4 only for this fix too? Yes?

Oh, I didn't realize this is scheduled for 4.5. It indeed needs to go 
into 4.4 because of 5f310f739b4c.

Thanks.
-boris
