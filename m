From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH 4/5] x86-64/xen: Enable the vvar mapping
Date: Wed, 27 Jul 2011 09:48:35 -0400
Message-ID: <CAObL_7G7ddd1NEWY_GNbt8kNRE+dbHC6A=sMLFV00q2AackuXw__14783.8861718357$1311774573$gmane$org@mail.gmail.com>
References: <cover.1311736366.git.luto@mit.edu>
	<b6598d164fbe64eeea37c0369b64dd6ceaeeb504.1311736366.git.luto@mit.edu>
	<20110727130604.GD6713@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110727130604.GD6713@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 27, 2011 at 9:06 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Tue, Jul 26, 2011 at 11:20:38PM -0400, Andy Lutomirski wrote:
>> Xen needs special treatment for fixmaps.
>
> The description needs a bit more, for example:
>
> "Xen needs to handle the newly introduced VVAR_PAGE introduced by
> git commit 9fd67b4ed0714ab718f1f9bd14c344af336a6df7
> "x86-64: Give vvars their own page"

Will do.

--Andy
