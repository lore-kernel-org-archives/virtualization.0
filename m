From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/3] kcov: collect coverage from usb and vhost
Date: Thu, 24 Oct 2019 16:59:07 -0700
Message-ID: <20191024165907.d56f8050b5097639263c0a41__31080.9684962564$1571961562$gmane$org@linux-foundation.org>
References: <cover.1571844200.git.andreyknvl@google.com>
	<20191023150413.8aa05549bd840deccfed5539@linux-foundation.org>
	<CAAeHK+xLS8TVioJeqYrf9Kso9TsiWiH0O-k+RrRBCKPPS9_Hrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAAeHK+xLS8TVioJeqYrf9Kso9TsiWiH0O-k+RrRBCKPPS9_Hrg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Marco Elver <elver@google.com>, Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, KVM list <kvm@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Elena Reshetova <elena.reshetova@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, David Windsor <dwindsor@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 24 Oct 2019 14:47:31 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:

> > is it expected that the new kcov feature will be used elsewhere in the
> > kernel?
> >
> > If the latter, which are the expected subsystems?
> 
> Currently we encountered two cases where this is useful: USB and vhost
> workers. Most probably there are more subsystems that will benefit
> from this kcov extension to get better fuzzing coverage. I don't have
> a list of them, but the provided interface should be easy to use when
> more of such cases are encountered.

It would be helpful to add such a list to the changelog.  Best-effort
and approximate is OK - just to help people understand the eventual
usefulness of the proposal.
