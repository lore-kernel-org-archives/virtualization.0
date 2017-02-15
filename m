From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] average: change to declare precision, not factor
Date: Wed, 15 Feb 2017 12:54:03 -0500 (EST)
Message-ID: <20170215.125403.419777696065228170.davem__27301.2846512303$1487181274$gmane$org@davemloft.net>
References: <20170215084926.29482-1-johannes@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170215084926.29482-1-johannes@sipsolutions.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: johannes@sipsolutions.net
Cc: sgruszka@redhat.com, mareklindner@neomailbox.ch, johannes.berg@intel.com, mst@redhat.com, netdev@vger.kernel.org, sw@simonwunderlich.de, linux-wireless@vger.kernel.org, virtualization@lists.linux-foundation.org, a@unstable.cc
List-Id: virtualization@lists.linuxfoundation.org

From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 15 Feb 2017 09:49:26 +0100

> From: Johannes Berg <johannes.berg@intel.com>
> 
> Declaring the factor is counter-intuitive, and people are prone
> to using small(-ish) values even when that makes no sense.
> 
> Change the DECLARE_EWMA() macro to take the fractional precision,
> in bits, rather than a factor, and update all users.
> 
> While at it, add some more documentation.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> Unless I hear any objections, I will take this through my tree.

Acked-by: David S. Miller <davem@davemloft.net>
