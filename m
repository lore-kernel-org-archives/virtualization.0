From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH] finish processor.h integration
Date: Tue, 18 Dec 2007 19:00:33 -0200
Message-ID: <5d6222a80712181300l707035e7mdb8a6e0d7a5ddca8__3094.79623470015$1198011747$gmane$org@mail.gmail.com>
References: <1198008293639-git-send-email-gcosta@redhat.com>
	<E1J4jSf-00024X-GN@faramir.fjphome.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <E1J4jSf-00024X-GN@faramir.fjphome.nl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, ak@suse.de, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Dec 18, 2007 6:54 PM, Frans Pop <elendil@planet.nl> wrote:
> Glauber de Oliveira Costa wrote:
> > What's left in processor_32.h and processor_64.h cannot be cleanly
> > integrated. However, it's just a couple of definitions. They are moved
> > to processor.h around ifdefs, and the original files are deleted. Note
> > that there's much less headers included in the final version.
>
> Either I must be missing something or this patch was corrupted somehow.

neither.
Note the else in the middle. It's just a mistake in the comment.
Ingo, do you want me to send an update with it ?

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
