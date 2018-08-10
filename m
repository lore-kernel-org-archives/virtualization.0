From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 06/10] x86/paravirt: introduce new config option
	PARAVIRT_XXL
Date: Fri, 10 Aug 2018 10:22:57 -0400
Message-ID: <cdb31666-f4ca-4a5c-6961-c6e92da722c1__23887.4885523275$1533910819$gmane$org@oracle.com>
References: <20180810115252.18213-1-jgross@suse.com>
	<20180810115252.18213-7-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180810115252.18213-7-jgross@suse.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com, rusty@rustcorp.com.au, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com
List-Id: virtualization@lists.linuxfoundation.org

On 08/10/2018 07:52 AM, Juergen Gross wrote:
> A large amount of paravirt ops is used by Xen PV guests only. Add a new
> config option PARAVIRT_XXL which is selected by XEN_PV. Later we can
> put the Xen PV only paravirt ops under the PARACVIRT_XXL umbrella.

What does "XXL" stand for? My immediate thought was "extra extra large"
but I suspect it's something else.

-boris
