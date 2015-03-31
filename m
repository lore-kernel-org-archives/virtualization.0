From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/25] treewide: Use bool function return values of
	true/false not 1/0
Date: Mon, 30 Mar 2015 17:14:48 -0700
Message-ID: <1427760888.14276.37.camel__17373.4707794667$1427774026$gmane$org@perches.com>
References: <cover.1427759009.git.joe@perches.com>
	<5519E53B.5040504@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5519E53B.5040504@schaufler-ca.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-ia64@vger.kernel.org, kvm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-hexagon@vger.kernel.org, bridge@lists.linux-foundation.org, coreteam@netfilter.org, linux-pm@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org, linux-ide@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2015-03-30 at 17:07 -0700, Casey Schaufler wrote:
> On 3/30/2015 4:45 PM, Joe Perches wrote:
> > Joe Perches (25):
> >   arm: Use bool function return values of true/false not 1/0

[etc...]

> Why, and why these in particular?

bool functions are probably better returning
bool values instead of 1 and 0.

Especially when the functions intermix returning
returning 1/0 and true/false.

(there are only a couple of those though)

These are all the remaining instances in the
kernel tree.
