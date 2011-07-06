From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] virtio: expose for non-virtualization users too
Date: Wed, 06 Jul 2011 14:55:43 +0930
Message-ID: <87aacs0ylk.fsf__37511.2939429984$1309999222$gmane$org@rustcorp.com.au>
References: <1309874774-31689-1-git-send-email-ohad@wizery.com>
	<4E1391C2.2090904@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4E1391C2.2090904@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 05 Jul 2011 15:35:46 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:
> On 07/05/2011 07:06 AM, Ohad Ben-Cohen wrote:
> > virtio has been so far used only in the context of virtualization,
> > and the virtio Kconfig was sourced directly by the relevant arch
> > Kconfigs when VIRTUALIZATION was selected.
> > 
> > Now that we start using virtio for inter-processor communications,
> > we need to source the virtio Kconfig outside of the virtualization
> > scope too.
> > 
> 
> Seems reasonable to me.

Me too.  When you're happy, please send.

Thanks,
Rusty.
